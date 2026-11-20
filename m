Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7078606A6D3
	for <dri-devel@archiver.kernel.org>; Fri, 20 Nov 2026 19:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dRYD7G3A
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 50387112CE1;
	Fri, 20 Nov 2026 19:20:59 +0000 (UTC)
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com
 [209.85.160.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4082E112CE1
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 19:20:53 +0000 (UTC)
Received: by mail-qt1-f177.google.com with SMTP id
 d75a77b69052e-55c48582654so15924901cf.0
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 11:20:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795202452; x=1795807252; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=5xn4C6Gwtp+D5V/nlSsDQf1o0XJ2+OFbQn76n9amPzk=;
 b=dRYD7G3AT59MSnSPDrU+Axoeqmuf11nPDLtY1AxrnIEnmyNEmkwPLjZNq1IqOiIp2+
 hXKm0fe7BVsQTVr4sNHP9BCo+PUg/xNUEuRfxlcapoP0j86HEEPDDj8lBURPdaTQxwd4
 DzalAyXO+s8SOhbcFnFQ6CDVadyxPmIDN8MECrmUiSvsgTm1hN1lOeXyvioqnuQX7k4q
 2t6wyU+nqAhsRMIjXJ10zpa+WVBUWA+FcbHOYVQB1HAnscqRvy2f/d4BYFHIv2e+qBZq
 5P445T6NslHGaO+gzyECUjygehvWy323YG5hqCGl8VfSU1HKn2HrUT0jAk06tgQcp6lb
 VDSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795202452; x=1795807252;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5xn4C6Gwtp+D5V/nlSsDQf1o0XJ2+OFbQn76n9amPzk=;
 b=juv6PzC8R+XmnFC13+zD01ndaPEkMvTz9IZp/zFet+vagtpfdqRsg3QOZqj0fNqOvr
 8B2aU8DuyZS7iFB2NZMBB1j8XfkAPs6IStI+bc7BSIHYV/O93y4AcdUPbHU2HRWG/nnL
 S15zSlWibCOfJqKY1I80tY7CMRrTJcrmScmk2EpVSeP6A9QQWuQ7miNJ9bNRnJm6zclS
 SP8QBF/yoTmNFBccm8ily3+bRqFd2cF2dH41gORbQNpXjitewI6zPKLEwS7Y9RWYBGpU
 NdTlONm5ah5X75QHQDkGXNpPgBpNpeiRhE/+CcrNjvD/u/KppGyiBwkSUkBj4PJOZHxP
 56IA==
X-Forwarded-Encrypted: i=1;
 AL+hErFa+0gC3QjoRXswLhzBMELipK85Zfm99GTSjZEiEAkUKYGym3NeHcxxAwjZi9a9VUuix8FqNQU9ttI=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9qami1Y080IlM4chKq5EWZis6/ePlZN9M9I5qQ7Sn9rVsj1SKx
 zQuQbofWxmpVEFRiuhpSA8tnVPOe8tW3G2KJyztImTvd552E9pM8VUHI
X-Gm-Gg: AYBFou0HKnLMWMDLa6F9S0fyEHbmYEA0vGB+uM4vfYMQAfQpenQFFTh5mF6FwR2D+3g
 lGdkRXnKrknBC2M2tfirTiRTiH6qkvPnXvkj41zB9wd0wEsFo+k9oAYNlSp+GHgP0TJfc7ViDln
 pCmWJXib593Ks107Ya3HiW7HWzv7UM8TVJMY5124yw8bDWfoj3XtHO3hmM4xTrTFG8IkTY7GN83
 9Rd8wlsSdqEO5RK3490MosVpJNXTlBNdln95LSxXQujJKwLNXvWjDgng94S/5frYJhcCdphBSFp
 +JqWhpBO30n5Nwoi7gDu/cq9xtGUbLpRWANlLSx+L6r0GSURA5JqfCWxGr9GlsMUEpVHo20gHU3
 704fkBgLO9pwjkZA37Z9/Y2igliSFWgk0R6dDP+yQY8liuB5We2v3tgBFPqSMETD+Hh2pgNLBoa
 f6UNtdtZVoAFrd5ys2z/9dCCncSVzDnnJk2R8CEbOITY50xEymckMFgMkXkYagrRVc0IJHa9FM5
 puKRLEokAv/8U5lQHU+cLfl8bs+fia5ojtaiFs/ntIKC5nq6g43b4lV34mGClRgxNAsqcZzu9p9
 Ja8RHBTDWB+ZtsJDpj6T2LWZ/scQ5y8J+yIM0K4alwzEM46Dn2w8qJOCx2E2WTuLO1zd8o0n3wT
 6G0icZ9Bd9wEKeb+PFkAWqSCAu1AE3AWvn9MzSxdKrQUG8vAcW9tAOxC1f3xTNtOLgves4wOX+/
 UdUCBFDNxe2VcHN4+TTBG3hHztZjgLCAe0eJJsMCFL8Etfx0bQbZjRbw4Q4WtrhgBv6yZ8Xek5o
 d09UclGtXmnBh0tyS0UFSbwJScDnM4EyJBx4cEDRVb19tvBH2+IHDuyli31HTVunHk=
X-Received: by 2002:a05:622a:5512:b0:535:1d90:ebcd with SMTP id
 d75a77b69052e-55d76a6f9ecmr76637611cf.27.1795202451996; 
 Fri, 20 Nov 2026 11:20:51 -0800 (PST)
Received: from LRMS.tailf8556c.ts.net
 ([2600:4041:5024:4b00:d420:4621:169f:8773])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-55d7882e2c6sm31475921cf.12.2026.11.20.11.20.51
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 20 Nov 2026 11:20:51 -0800 (PST)
From: Jesse Casco <jesse.casco@gmail.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>
Cc: Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jim Martin <jimmartin@gmail.com>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org
Subject: [PATCH 0/2] drm/msm/dp: make the eDP 1.4 LINK_RATE_SET path work
Date: Fri, 20 Nov 2026 14:20:48 -0500
Message-ID: <20261120192050.73315-1-jesse.casco@gmail.com>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The eDP 1.4 link-rate table support picks a LINK_RATE_SET index in
dp_panel, but the selection never reaches link training: only rate and
num_lanes are copied into link_params, so LINK_RATE_SET is never
written and the rate-set fallback branch can't run. Patch 1 carries
the fields through. Patch 2 fixes the fallback once it is reachable,
so it stops at the lowest table entry instead of dropping to a standard
rate the sink was not told about.

I found this while bringing up an ASUS Zenbook A16 (Glymur), whose eDP
1.4 panel lists 1.62, 2.7 and 5.4 Gbps in SUPPORTED_LINK_RATES. At boot
the firmware has left LINK_BW_SET at 0x14, so dp_panel picks the
LINK_BW_SET path. When the compositor starts and the link caps are read
again, LINK_BW_SET reads 0 and dp_panel selects the rate table, but
without patch 1 that selection never reaches link training. With the
series the link trains through LINK_RATE_SET (5.4 Gbps, 4 lanes).

With a test-only change that fails the first clock-recovery attempt,
the fallback moves to index 1 and the panel trains at 2.7 Gbps,
reading back LINK_RATE_SET=0x01. The lowest entry of this panel's table
is RBR, so patch 2 does not change behavior here.

I tested on the A16 with a next-20261103-based kernel; the patches
apply unchanged to next-20261119. They touch dp_ctrl.c alongside
"drm/msm/dp: don't fall back to a link that can't carry the eDP
mode" [1], and the two apply in either order.

Jim, Cc'ing you as mentioned off-list: Omarchy's arm64 kernel carries
patch 1 as 2367 with your 2368-2371 on top, and your 2369 covers what
patch 2 does. I'm happy to drop patch 2 if you post yours.

[1] https://lore.kernel.org/r/20261115000021.78869-1-jesse.casco@gmail.com

Jesse Casco (2):
  drm/msm/dp: carry the eDP rate-set selection into the link parameters
  drm/msm/dp: stop the rate-set fallback at the lowest table entry

 drivers/gpu/drm/msm/dp/dp_ctrl.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)


base-commit: adcad7f4e6332cff3d6d7165f41584899f598534
-- 
2.56.1

