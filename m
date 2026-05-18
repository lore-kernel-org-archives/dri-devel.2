Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C800FCD4F3C
	for <dri-devel@archiver.kernel.org>; Tue, 19 May 2026 07:13:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6019510EAB3;
	Tue, 19 May 2026 07:13:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="k++04R3/";
	dkim-atps=neutral
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com
 [209.85.128.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 58F9010E5DB
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 16:15:56 +0000 (UTC)
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-488b8bc6bc9so14543065e9.3
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 09:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779120955; x=1779725755; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9TXq6OAKtTy29c2ZSYYSiFXHX6iuG3bFkK7SUcGbhSE=;
 b=k++04R3/bUndqbh7PU1s5IRgGLLCA6/g8Z7kzJBn9gVvW6AMw1bvZtp09txDGk/Dow
 mPefD+KFbdJpb6eu/CkOLFDpGWOCTVAXEDjeHa6pl42PdPV/zC4bmVBlsH3l9uS6Vjkl
 6kDBDUwWSlmEl/u4QnfCom/cxB4EBlesiNPG8otuyVN3XWv15uMCtG4q6CTLHw4/ph37
 hqaUrpfoWPiAkjpYiYFRWS0ZJPMwVDRtT/H2KkLz5H+GGxNHsxcOUiozil6HL6/15qBT
 Qcy4kzuWeuNymk/yl77D2RafWG7SgLjWO7rrRe+5RZ4kg3tdJTeEhbjNbakYAtvatMOn
 3hqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779120955; x=1779725755;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9TXq6OAKtTy29c2ZSYYSiFXHX6iuG3bFkK7SUcGbhSE=;
 b=qcv8L3ear0o4d61R1wU//Gd6YRnUBRJ9MVWvUUPiYU5XtJuKxS3fa6+hEveBglYODx
 ChoC1bghMncpSIlNb4rIpJQAyHWjz2pQNAWy9pTdynykqGxrzFMf/AWk83ruHFwHn3Dx
 pOyyYYVRAEdbj++7d/SetAIn2M+a+qwFuaUgH73f6+4g90ZziHf1P87sNUIvDCcjG2mw
 gm2wEXT88n5rGgExvwnbZqAP/dkmo5t3WMOrSkYAxufWkQHV3oXtN0H/FQxcRV5/JG3V
 hSjLt9/WXy6sG8mQ+HZmgnO8diwt5w2EVrLAsu8MJ53mvdoJtJrHDm9znaVmIxMLz3X8
 NDwQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9947VMfh5F7m1Gnbh6uPqpD1fswTV5ZUFfiVuYyYwxeH5PaUo3wTw+1aNA//Z64x6ZrMUfZxvcYl8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Ywd5/raaXjtgEGTdPXz1cjNOLF2ZqiNETObi0EMG438xPimcVKq
 kW69LS36Cm0Kb6juebq/et7E6sfyIudCVmMrqIaBI1wWoiR00h6fskah
X-Gm-Gg: Acq92OHVtGg+suDf4eVepYjw95QoeOeJeZWjOMdWfa2fiQXSvVAsrqQ/dwZWRqczhgR
 yWvvKDy+aE5kTsm+pgrIrdEzPSAiZgMtcylp/ttKkp2pZsm0zrOd36zmR1MuZ/2XTQvagWq11wY
 tnwWlbs/8SUEeusUEUuHzIxo/wMhqQr/dyTUR/CZkORpAcpDxle6nOXE1V81fww/9J44c/hWs7J
 Dmz/YLPmo2U54u6Ya5njayvHo8XV+XRsaJvhqYklMgsLeQBNrRTh5PyYLSw+tUsRCLr+RLUFSr0
 XCbfAc36pA4JwRKwpzIqHPZxjxgL9BoKyaroomC+U7dPYxKypGWNSZsZj/zrZ+pPY3QgpQbtn6C
 SB+rRsJIDXhY8y0sSuT8ZCZoALualLPQKaJRi0ELllPH9RUZeh7ZQXrK5e5UTskWXSXlwTALydW
 wLIBnTM7rO8VP8/RtQgBbQb/CSejEulO53SLRRGih7A+h/yQrMLWrscmg=
X-Received: by 2002:a05:600c:5ca:b0:48f:e6de:1cb9 with SMTP id
 5b1f17b1804b1-48fe6de1dd2mr148159215e9.19.1779120954812; 
 Mon, 18 May 2026 09:15:54 -0700 (PDT)
Received: from RM.localdomain ([92.53.30.157])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48ffed68baesm67076185e9.0.2026.05.18.09.15.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 May 2026 09:15:54 -0700 (PDT)
From: =?UTF-8?q?Rahman=20Mahmutovi=C4=87?= <mahmutovicrahman5@gmail.com>
To: linux-fbdev@vger.kernel.org
Cc: deller@gmx.de, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fbdev: sunxvr2500: replace printk with device-aware
 logging functions
Date: Mon, 18 May 2026 18:15:50 +0200
Message-ID: <20260518161552.574-1-mahmutovicrahman5@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260509135759.1391-1-mahmutovicrahman5@gmail.com>
References: <20260509135759.1391-1-mahmutovicrahman5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 19 May 2026 07:13:01 +0000
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

Hi Helge,

Can you check my patches and let me know if any changes are needed?

Thanks,
Rahman Mahmutović
