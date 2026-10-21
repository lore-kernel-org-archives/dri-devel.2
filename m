Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6217C606A319
	for <dri-devel@archiver.kernel.org>; Wed, 21 Oct 2026 08:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=LpgTKIzs
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8D96410FCCC;
	Wed, 21 Oct 2026 08:52:09 +0000 (UTC)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com
 [209.85.128.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A202210E03D
 for <dri-devel@lists.freedesktop.org>; Wed, 21 Oct 2026 08:17:49 +0000 (UTC)
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-49d05d51553so2720405e9.2
 for <dri-devel@lists.freedesktop.org>; Wed, 21 Oct 2026 01:17:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792570668; x=1793175468; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=dJyr2tsSRejcmBK3MBzVGDDB5htK2NHRSw/F+Hou+2A=;
 b=LpgTKIzsVmdTntC7/fwZs2wqkbCF4wEjk+Ef2BaV7/8FRw+MU4v1UPkjpLe0Iac4vU
 znEEAyOQMxqJfVayyrqUypxyZETc0GVjcmPA9RbznSLQWqwEhCvyQY0UUFJgJ6fUaWp7
 YRDltwlVNYDLb+bGLa08fuVZEkJGXwRVfiQrQaM52+h1N9MBTFM3gxnbgK/86Jjr5Zge
 dHWi3P/76HVc8eR5S185/KpT11fQkk0x/RLlP9mLnT1AUpn4NgrupWoKMBqi8PaKwuyG
 Jv19yI5twqKnYQSe0xdvtBOXW6ewbeyJRHDYECtV1MCu86q7EgVOYcdB3pwcPZ0+QNfv
 gS6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792570668; x=1793175468;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=dJyr2tsSRejcmBK3MBzVGDDB5htK2NHRSw/F+Hou+2A=;
 b=en1eAadffSgYKhg54mjQr6mkSRhLSOnC+1je9ReIY1FzPd7iuxMR0LQWRxmSZwiGHA
 i1ThcOFDcIk2+QI/9A0kc9VCrYKl2Z2heEg7MKWwqA1UCDHcPBBQtFXVRGrL2eG7JMLq
 ekMQS8Yq31PzsVWk4uRSuCSla/HSYf+59vrNu1rVmRrh4ADmJ6tEJRT8a/FiEEIQQkv2
 bFiD3raFaANRscocKaIMgist/r9k58OQ089j1ypNLcorje1AxTQ/EGU9DEGYA75i59Rc
 HMb8n/OQ+fSskG34P2rQXklUlYuAayBnLoNe9ySYF+FtgBG5p/YhifzcFqvaG9w/eWPB
 ypcA==
X-Forwarded-Encrypted: i=1;
 AKwUvBx7wtA5vVMgMspiMVIeyh94peh8BtvSDlbxcIeZXLNfPsXXUNyCzBtAjtlgo+kZqWLIRfXWo39sw28=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJcks9rnPaIcWhWX8HEniHvFUmksVGlRqtZnBsYLWCcaxPJZEEE
 SKh2ujE5fgloxrzVa9NbjaxBKXKC7sklqC5eajNR8qK+yPIQxNp5KjM8
X-Gm-Gg: AYBFou1R5xNmRXZ54JcJw5VothuZbnyx8xOEN/dyIyv9hU5ZHYRHe/yRHrI360X/ArU
 jOySehAHSgIJB/zGcGrpKUJlbEzlTJzzmd4hT5/IgKgLmGhGTSvBpyERd2WE2lASfy+8+joop8K
 Yecbg3rRKGGxDgpNlLMzKAAL05Pf2cshTtl8A/UshFYPsdCKxe04laf+H/EdD8x1LozTLwcGDDI
 BqCGRL6o+Btatvp7tEeZzRLO/ltJ984nyFmBVPpdcHRKRxBnSpCTkI9/dnPEZNa290CEBinRglw
 Ns4o6CnLiUIlERPO4Wlfse8XOO7XBsNAdOkahbga/VM4tQhuEk3vwpK+ut9DFkuCgygVc4jF/Ll
 6YoR3LZ6EqxtXYqEM2cqIH5s5l7B/FjqGmP+gtd0zzcSJTk6V7fEJCfpNuvmBkifGy5d7U3mc0h
 l1CBaQMPg8gv+KfUjDxH9TE9Smsm4jv9Iq6rlnjEn2S84qMfMvrDVZeQk4iscHlA7Xxl9q6oFCl
 CiOimkDmQtN7X0wNQgSjhswU8wn2T92hCoM+4ko+o+2uIz46xeS7NMOj8HhiuYS4A==
X-Received: by 2002:a05:600c:c8c:b0:4a1:e489:f8a1 with SMTP id
 5b1f17b1804b1-4a1fd89d90cmr22391725e9.2.1792570667667; 
 Wed, 21 Oct 2026 01:17:47 -0700 (PDT)
Received: from localhost.localdomain ([94.252.75.12])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-48e25828c98sm3848877f8f.28.2026.10.21.01.17.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 01:17:47 -0700 (PDT)
From: Oleg Keri <okerixx@gmail.com>
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Rob Clark <rob.clark@oss.qualcomm.com>,
 Thorsten Leemhuis <regressions@leemhuis.info>
Cc: Bjorn Andersson <andersson@kernel.org>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 regressions@lists.linux.dev
Subject: Re: [PATCH 3/3] drm/msm/a8xx: Enable CLX feature on Adreno X2-85
Date: Wed, 21 Oct 2026 10:17:37 +0200
Message-ID: <179257065767.2798.872990041874023890@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <e4e2b8d6-46e7-4f59-994e-39f3d09d334d@oss.qualcomm.com>
References: <e4e2b8d6-46e7-4f59-994e-39f3d09d334d@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 21 Oct 2026 08:51:51 +0000
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
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Sent: https://lore.kernel.org/r/20261021080517.2161-1-okerixx@gmail.com

Narrowed it down meanwhile, with the clamp corner selectable on the
command line: gmxc pinned at max is harmless. gfx pinned at level 11
(0x1c4, the top of the perf table), 12 or 13 fails every time, level 10
and below boots fine. So it isn't "the rail can't follow", it's the gfx
rail sitting at or above the highest level in the table while the
firmware calibrates. CLX being a current limiter, a limit entry would be
my guess, but that's firmware territory.

If the CRD still fails after sync_state, gfx.lvl being held at the top
level by something else would be the first thing I'd check there.

Oleg
