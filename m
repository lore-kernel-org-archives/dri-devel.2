Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9E18606A32C
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 18:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=GLkKZvcX
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 19BD710E9F6;
	Mon, 16 Nov 2026 18:51:49 +0000 (UTC)
Received: from mail-pg1-f227.google.com (mail-pg1-f227.google.com
 [209.85.215.227])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7C42510F3EB
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 18:51:42 +0000 (UTC)
Received: by mail-pg1-f227.google.com with SMTP id
 41be03b00d2f7-cc4be0e5351so1507583a12.0
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 10:51:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794855102; x=1795459902;
 h=in-reply-to:references:from:subject:cc:to:message-id:date
 :content-type:content-transfer-encoding:mime-version:dkim-signature
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=AG7lrMTMdTpXJhWWHRqMPbdBjQM52sNir2Uelum3Q8s=;
 b=M7DcsU8XejAUsQKlOKENRnEyhwbGrlrDBuGcpfhNU9eUkNQ64+wLesiYb5Gkry+ucS
 Ryzexeevh7A604MBN9N6wsnrXqNg7BVuwPsCCZ289NyEt9ymIcbquWOLuWOvB3lZSxbe
 Kdc5Jjqf7HRae7NJ7tMTTR7AxZmqNWVQtsRGLwmLtOSgflKpvzOKGDQ8Jmx/+TCCzTdv
 YvZFCbYu/vRt6yAxZthBbqJ9WzVaNRUTX2pKUEBbf34MqNAO7QV7SdFQs7MVIE1CxJpD
 PXzpSrrnlpeqgkFXBkcC7ttHW+dbPPVWASjLG/BxcsG39rEBkQul1kzVPf7r1qK84iO0
 cz9w==
X-Gm-Message-State: APuU4Z/xunYRbK8EugoC9ReNjIIlmPhTfTfDuXuzZlaLJzpTKUOlttK3
 2YfvCH1u8jAcKc1Lwu7SrciHRJtsbPm9G4bPwPqJBtVd3S3K661d1bqr73l3rIF7jbV5macaDGR
 kQdT2p2nYhSAcG1JOj9ZcoXG8Wx/qAdBUiX0nfHuZznakvlKbr2bV401wuFnEnJJ3lwaE6Ol+RH
 593yJRj9/3glZUT5H1EIYWatIP5mVpS5iCnLs38wMJIm4NLjefq+OZWi/KikadZSk5UkIf+pPW4
 x1mN88aZQ2FtlOM8BublWniqj4Y
X-Gm-Gg: AZFdTZcJTT5VHfIO/hgLCWF5yWqjWEn20Ov3wYqBobLXJGA7vrF05/qgNv98avWFm8C
 N8VVO0noqaK2Zl2Mlbmzn7E240JJTgR1q9xZdDvraMKwkLzK9ACPbvoNooxhb2mhKRqeul9Pt/E
 Sgen+TCYJ+3ATBOUkll7iE0tMnFVWJ0C9O3ZbB2kOdpxRn6PTzNWJkU+n/KljQ2Rxt/K8ilsXgR
 7OsPmFIwoffFtcgEUBCJBJY1YPmDmQEV3swGe2hZWdTabVj+Q1K4yRiw2PM0oGpXhrM/bEinhPO
 U2mrkyqj5XtR/gClxCbcpsTy1ySwCXU6FEnoi20wmOp9krnEZg0VeIUMPIZgKvMVDuG73kKluWm
 FSCg33BZ1uqpH3yle7LgPkjj4UHT1pQtFCgP7cHnvS4y7AebX09VGmx6piEuJBDerlzA6Vy0nzd
 +oc2DE/NKejfxNb9799jYIIUr90Csfv2CfR4iFl702r48=
X-Received: by 2002:a17:90b:4a4e:b0:3ac:83c1:2bd with SMTP id
 98e67ed59e1d1-3b1b0a3a2eemr10903056a91.28.1794855101900; 
 Mon, 16 Nov 2026 10:51:41 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-123.dlp.protect.broadcom.com. [144.49.247.123])
 by smtp-relay.gmail.com with ESMTPS id
 98e67ed59e1d1-3b1b25d9ba7sm3858685a91.1.2026.11.16.10.51.41
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 16 Nov 2026 10:51:41 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-944138ed63fso581256785a.3
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 10:51:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1794855100; x=1795459900;
 darn=lists.freedesktop.org; 
 h=in-reply-to:references:from:subject:cc:to:message-id:date
 :content-type:content-transfer-encoding:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=AG7lrMTMdTpXJhWWHRqMPbdBjQM52sNir2Uelum3Q8s=;
 b=GLkKZvcXKd3l3q1OnyJws9u4mCS58B2ZXXPj/VDxhIzZbcP66rntL/uxbfP7KhAa/x
 qUO91ovz541hn7kn/wL8zCpZf8F8FaB1EYARGoHooKXoa3kCls4Gj+HN4fCweAEZ8Gp4
 06/wNCbwempT+pHXA2cBmzGCtrr74qhro5N9M=
X-Received: by 2002:a05:620a:7082:b0:93f:3219:835f with SMTP id
 af79cd13be357-9494bd2cae9mr1794631485a.81.1794855100575; 
 Mon, 16 Nov 2026 10:51:40 -0800 (PST)
X-Received: by 2002:a05:620a:7082:b0:93f:3219:835f with SMTP id
 af79cd13be357-9494bd2cae9mr1794628685a.81.1794855100164; 
 Mon, 16 Nov 2026 10:51:40 -0800 (PST)
Received: from localhost ([192.19.50.250]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9494c836079sm905381685a.18.2026.11.16.10.51.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Nov 2026 10:51:39 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 16 Nov 2026 10:52:57 -0800
Message-Id: <DMWV25PKBWPA.O0T67JFNRN9W@broadcom.com>
To: "Zack Rusin" <zack.rusin@broadcom.com>
Cc: <dri-devel@lists.freedesktop.org>,
 <bcm-kernel-feedback-list@broadcom.com>, <ian.forbes@broadcom.com>,
 <yunfeng.li.nb@gmail.com>, <tomas@slax.org>, <stable@vger.kernel.org>
Subject: Re: [PATCH 5/6] drm/vmwgfx: validate the framebuffer selected for
 cursor updates
From: "Maaz Mombasawala <maaz.mombasawala@broadcom.com>"
 <maaz.mombasawala@broadcom.com>
X-Mailer: aerc 0.17.0
References: <20261027211729.646988-1-zack.rusin@broadcom.com>
 <20261027211729.646988-6-zack.rusin@broadcom.com>
 <DMMXFHCWWRFR.MUE8FPMJCZEG@broadcom.com>
 <CABQX2QNoumTwtyYwPSGJ+jCfcFgfMue9ESNH+ch7_GmU_JT57w@mail.gmail.com>
In-Reply-To: <CABQX2QNoumTwtyYwPSGJ+jCfcFgfMue9ESNH+ch7_GmU_JT57w@mail.gmail.com>
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Aah, I see, thanks.

LGTM!

Reviewed-by: Maaz Mombasawala <maaz.mombasawala@broadcom.com>

--=20
Maaz Mombasawala <maaz.mombasawala@broadcom.com>=20

