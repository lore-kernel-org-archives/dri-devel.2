Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6F3ACD342C
	for <dri-devel@archiver.kernel.org>; Thu,  7 May 2026 00:34:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1A61910E21A;
	Thu,  7 May 2026 00:34:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Wksc5n/w";
	dkim-atps=neutral
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com
 [209.85.222.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E63C310E21A
 for <dri-devel@lists.freedesktop.org>; Thu,  7 May 2026 00:34:33 +0000 (UTC)
Received: by mail-qk1-f176.google.com with SMTP id
 af79cd13be357-8dbbc6c16b2so38280085a.0
 for <dri-devel@lists.freedesktop.org>; Wed, 06 May 2026 17:34:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778114072; x=1778718872; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=29aihUt4aWmSHOAGirxV/stIKdylAvxvcEZukkF7pvI=;
 b=Wksc5n/wzuZr/Xa0D+uRn7ciznOldyEQ8N6ZkPjUJzEJ02arqGCwd4lxF1rWWkoacq
 UOmfXDUxsyxlksH/MzPcuejhSeNR0qLhmuQu5Vy3EHsS019o1lDTxTb/Fuupd0+Pb4wE
 7WiQn49cTbZ6aDIRFIyLub3kTPIIaA7TiJloMzYsxxJiYb5FNi2DkiyKVnbUP4nTINOK
 kz5UJR/JyMUTaAmpYOtmM/5Ppn8/CAt9OlYrUFywPtETjbzajKznh4CvJMXavJGYo5kY
 1bti9TCSxTmUpIsNT1tfB0K9C3WWkicq9kbrzQ8zbxy1+Z9a/HRuCsPUnQGow/t8O3h5
 sLkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778114072; x=1778718872;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=29aihUt4aWmSHOAGirxV/stIKdylAvxvcEZukkF7pvI=;
 b=j0ZUhj8wDVY9OQybEoFmf+RbOxMNrwj419UWaJIcwPYe/AVOimZGrdQGoKP2FyStRw
 DmrEip1lfb+0/Wn0T+/c0K8MK/TCQn8qttamShsl6IG4ieIq9IMDlvGKh5kBHLJ/Ll0P
 rrG/zDkLO1u+dHwCMjkAja0UU9hLITMFdiPx5WvJNoDivUut2WP8gbOrSaySq6x6Dvov
 2A9HQaXZz/6RES6l98kZh9uXFJoRUZzge2cKbK+ERh22E5zJSeYQsxnDZefVN5YJkh02
 +ULOVWRgJj7sZ1hxT7WweD+dXsR7Lj8YZBViTriN5rDdpJSx/W0FTi6j26jeEh9djwCi
 FzJA==
X-Gm-Message-State: AOJu0Yz3EkbR4wfKK/hpLvOBh3PnvARG7R23xifo8k0MaPEDeDfXWM9a
 Qj70cm2BdgYy6r/dzcW37YzEVcYQ0kfqcgJoVXNM7/pA5FzqrolyXGKJP+9w5KhQhEXLEw==
X-Gm-Gg: AeBDieuzcw6Q/WtnpsTONTtb7+7WLqgz7pGWmffCmDMpoWOo/YBkZaYgZ5GqJmH0mRJ
 THzYm1ehWk2xeggiItK8jM0nUGSqVXo0JB5FvJIYuFXWffZbTc2Z9h8mk4W0OTKtCdNjn8Osbmv
 VGWNXwd2qKIxC5F8zwJZJRf0cYreVgdyPO/q0FVXBMcCpWAAQxcjdskJ6eW5AQr4FIcCvznd8Lm
 JbC6e3ztCQm1cBOhWS7DGl/+k51P4FfLB6YsqO0cjEIva3xWnZ85xNCg6xJczfxSGpxwpGxD0ed
 +IN7ELYbh8ZDYsK2Psm17/zjIjZeDsY6iKSkTwKNvhXHIo3aPLa4HVkzeisR5oAEYJ4BK7j9nGE
 FSj/Td8+4U2RgxQU16z8v8xsLIn3dAiw8+nGOY7wtCLowcNcbpHBkMsHpFNkdzVkgp7XCWAjH/e
 GGAmHlx6PS1oysD4XWSiLyOKTy3IYx85pq6n9z1YlimUAWvztecg4KYmDz234s5rSWTwPuVT0T2
 08U4fq34qTHrNfeUHr2ZUknRemmr7OasiBFTpw=
X-Received: by 2002:a05:620a:1786:b0:8cd:e013:bca0 with SMTP id
 af79cd13be357-90652c63a13mr111148485a.33.1778114072382; 
 Wed, 06 May 2026 17:34:32 -0700 (PDT)
Received: from
 TDC4045031631.e0cglfehwr0e5gttmepj3hi3hf.ux.internal.cloudapp.net
 ([20.63.37.123]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8b53d450dcbsm193358086d6.45.2026.05.06.17.34.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 May 2026 17:34:31 -0700 (PDT)
From: Ashutosh Desai <ashutoshdesai993@gmail.com>
To: dri-devel@lists.freedesktop.org, stable@vger.kernel.org, lyude@redhat.com,
 airlied@gmail.com, daniel@ffwll.ch
Cc: Ashutosh Desai <ashutoshdesai993@gmail.com>
Subject: Re: [PATCH] drm/dp/mst: fix buffer overflows in sideband chunk
 accumulation
Date: Thu,  7 May 2026 00:34:23 +0000
Message-Id: <20260507003423.985823-1-ashutoshdesai993@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260410041901.2438960-1-ashutoshdesai993@gmail.com>
References: <20260410041901.2438960-1-ashutoshdesai993@gmail.com>
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

Hi,

Just a gentle ping on this patch from a few weeks ago - no rush at all.

https://lore.kernel.org/dri-devel/20260410041901.2438960-1-ashutoshdesai993@gmail.com/

Happy to revise anything if needed. Thanks!

Ashutosh
