Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8225ECD4F3C
	for <dri-devel@archiver.kernel.org>; Mon, 18 May 2026 03:04:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C97B910E2C3;
	Mon, 18 May 2026 03:04:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZlonhWgc";
	dkim-atps=neutral
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com
 [209.85.215.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 05DC510E2C3
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 03:04:38 +0000 (UTC)
Received: by mail-pg1-f171.google.com with SMTP id
 41be03b00d2f7-c802196bd32so80459a12.1
 for <dri-devel@lists.freedesktop.org>; Sun, 17 May 2026 20:04:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779073477; x=1779678277; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YrxjtDTNgHDLtXt57ombRVo2sbxeJ2Owhr7VJ48SGuM=;
 b=ZlonhWgcHHx+rLb3LWH/Q553oeahKZKoNogg2DgPt7UzuYrCLlw0LXypCMxnscrFdt
 3QZqhIxCuPMXIZuy6PxShzFEh++bB0d5InRGvd9WjwbJRFKwaxUK/cgxX0yT5VaCF3hg
 TmkLJNXSlzTpqCYpDzJALpP4ftTjaFdXHFmb7d7VJBPEAgXSjlz1InUO4OT8lF5NeNs2
 8G1ApWau7RfRr7kBCgUxqV4ML1mStGH9pobg7Q7l8gl310Il3f+Aq7reO6JA+SaFUjqF
 g/IVzfuJNxsRjODJIwdI7Z2jhCyF5jWX9Cin0W+Ds2Bu9C4u8NIfOhyLiRvUYcUyIgJU
 d5GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779073477; x=1779678277;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=YrxjtDTNgHDLtXt57ombRVo2sbxeJ2Owhr7VJ48SGuM=;
 b=apMRxn17kNTqPcoNtkqvT6DXWh20LmCg6HhDQu9QifYTkzCYbhpovICcAtEwtyK/Ge
 edzvMMAnSyoB34a3F/vQd4wpiGapqlZq3o/HTnotBb6RFfZAJNMgZFMTXjWRxSKb2oGm
 b8Fkjx41u9ZPH0u/5tZNFn6Vx/ZuzBfJuZ/4+GwQIXtIBDxc248mPIw6i6ibAjuOnLNb
 TKGgYB3QoPHbqOcAZfspZy69AFF1hIYk0dG9lK24uSGRgoHR61R6bpYFGlvJ4hn3kFiB
 o00JAHrPecfovVlUXrh1CKgE8RUAfhYLXIgNleIIpL2LksgvJLj1RiXAdARXSAEKiR7v
 pb0g==
X-Gm-Message-State: AOJu0YxCT8uO2vErPCmR9loXt6JCO6Frc/mfQyYs/u2Lxop3r38ZDhtU
 SUHifHtJt3nEfAeECrj4VkL84Fc1r9agzCLjFc3GtnSf8sVoOLmKTgbZZS1/Gg==
X-Gm-Gg: Acq92OHoZSzvxDYihDfQL+T7YmPjI8f0c4UBhHdP24dlbe0kamLGXzK+9ktDKkaNoyw
 7fWDtpWkJSo+7E/Kyi/wIPnYYN859zlTHzdSH7XRGZRmrK2EZotsvHCGl9DADZSR0OH705wSo2C
 mJ7J/GegHh5T+lYEf4bgNFJGm5dpr/Sv6tcQZ/UBn4WFyaQcnBh0Wf/2zJsArWDR0Fk5CGl9nmX
 pEyg8h3hUOnstvKpnJif3ovsPikz5okfvwOUd60ucjVz5tEKyKbwBiecqR7FHkLeJYNPAHmGHLv
 SA/OIMdEaHaLg07ZBnvgbkEYgtCogFDfIhJE801QMrYgid/mxvwGrEZ0JIykTWz8vCOe3jtXjQw
 wgdzn8aszr56ZlhJScWe0cNDwGY91v50miPbJ5UD0ydH8FllOY1/etRcddF++71CQilYjUDeuOs
 ywSLcSQEeVgKHwbTdKMvR7Ug==
X-Received: by 2002:a05:6a00:39a8:b0:835:3730:5731 with SMTP id
 d2e1a72fcca58-83f33ad5901mr7794512b3a.2.1779073477458; 
 Sun, 17 May 2026 20:04:37 -0700 (PDT)
Received: from marchy ([2405:3800:84b:d130:ee8e:77ff:fed4:d18b])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-83f19776733sm12637117b3a.13.2026.05.17.20.04.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 May 2026 20:04:37 -0700 (PDT)
From: Adam Azuddin <azuddinadam@gmail.com>
To: dri-devel@lists.freedesktop.org
Cc: devicetree@vger.kernel.org,
	gregkh@linuxfoundation.org
Subject: Re: [RFC PATCH v1 0/2] Migrate RAiO RA8875 from fbtft to DRM
Date: Mon, 18 May 2026 11:04:34 +0800
Message-ID: <20260518030434.431556-1-azuddinadam@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260505122636.11859-1-azuddinadam@gmail.com>
References: <20260505122636.11859-1-azuddinadam@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Hi everyone,

Just a quick ping to see if anyone has had a chance to review this RFC. 
Any feedback or guidance on the driver would be greatly appreciated.

Thanks,
Adam
