Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8FBDC624DA
	for <dri-devel@archiver.kernel.org>; Wed,  2 Sep 2026 20:18:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F0C6210F343;
	Wed,  2 Sep 2026 20:18:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="n5T54Ehs";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Lvo2YDIh";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6921110F343
 for <dri-devel@lists.freedesktop.org>; Wed,  2 Sep 2026 20:18:27 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 682KHWR22686502
 for <dri-devel@lists.freedesktop.org>; Wed, 2 Sep 2026 20:18:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=nQGNtigd/fh
 Qj8k99E1cXDjPd48Xc/BcsE7CCfKWZIU=; b=n5T54EhsFCac0SeU5D97p7M0YyQ
 OQP1d0SiagH2QmIaJgTg0EzJqAasz7GbSsSPgUw2R5IJKN5KyjDdv+DO0Rik54jE
 Bw2ZYVdQ/cPd0iB5Rya3x6gJSo0zOOi5xs+R2+lI1ZraYlDfpII2Kju77CMQhqq1
 kK2P51HgZ7pos/Fkkp4EMGCSK6kQA/B3WSACwICogt3xvn0rRFQCCjtomCESoywQ
 hdJHu110huHjIB6qTqqapo0sKyxDfgmizZ5IWbyX/yMQ0sY/FvNGJGoNx8oXqqAr
 mXJHiTmzb2USb616HCS79zAQNlYwqyhwmVHKR2UWQd2CiF/orhDCnJuwgcA==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gejv8a892-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 02 Sep 2026 20:18:26 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2d7151120d6so23330415ad.3
 for <dri-devel@lists.freedesktop.org>; Wed, 02 Sep 2026 13:18:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788380305; x=1788985105;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=nQGNtigd/fhQj8k99E1cXDjPd48Xc/BcsE7CCfKWZIU=;
 b=Lvo2YDIhRSZKijyKTN1J/HhzbWOj/5ithDsoQynVw+zAHtNqD7kPooWKKEIl4Fp2XS
 8gLV6kW1fOnaRFDfDkLRa6ZLzOi6dqr9qkDJq7tjh3az5wcr4QlbD49m+vVxCGsh+Cmv
 ud4BUda0+ejdNgDb0muGnaJBut8uuG5e7EDk53DZFnJ/kEPRZkqcLkUECisxgPrlZSrA
 2h7U3yfkagX0zhMi8jCKqbSld0UmIlFultxnpswW0R5jfwhNLv/Muul5DRzfV+4yGxjs
 OQx2RpaC/gQRoKQbbiRPg+4Dv2QFqfGA+pkI5b3uQPsZKXZros8Q5I6UU4d4Opbcc2yG
 c5fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788380305; x=1788985105;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=nQGNtigd/fhQj8k99E1cXDjPd48Xc/BcsE7CCfKWZIU=;
 b=CXOb4ePyDSwqLna2JQsEAKFTEs4VySUp2E+x1kAeUKF3M5Ly7HneHstb0bZ618vz36
 utIWbJLzciBB8yzSmz+yF1alU5yukFZXCu8KZfFleh1x/BMGyMNOImzPUvcebXGU3qsq
 tMEVuC+Ba+uF0XfKxsKdr43YJD2Tgr04epP2aYwyjBr9J0929Vj/sZ/lwHVBINVfCMQh
 wq5MJWJzWtn3zctATFgThiXV9H/3U6OMNRR6Pi6Nr/QQifDDIRbjWSXpRY1WPcerwqAL
 hwk/h+4Se70fp95wnHh6LHmUEkGqabN7Z9agXVhzNybY1556WuvsOAxyThS7x6Nm7nmd
 KOnQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzjOmb6wXV/Jky9qyOwbC5Vc06NapqDUEkUUZdNhXrjbLSoG9UTQ/i0tWd5dG0NBnWK9K4piYdiMMM=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mrAn8MqSCTEfvGZZz6tozxsr+mH7zCV3Cbbx4tKYc8dJMXeZRW
 8x+gKL8jhQnvzozJl9HBa/6kTL/FHdDZeNHBYGeRY3hX0ui00SaZexBvVKOsKMB49GiZcVreRim
 Qfove9IXXKWyGBFbjSYDW/6sMJq+Wj9wOMwMW4dBosDN9CFkee/nN4Xjc+fTDhph+rtQ2euE=
X-Gm-Gg: AYBFou0MoBoO8dbtu3GoW/YocMTT8RhGPmDfQ7XFPxcsvrgsi37u2T3U7jj4WUdqVo9
 hZjtqSBT4jiq/1wKy4zGXuLjrDDrGZV5tgwLYUHzTmq8i/yh7S6tAaFzIajah71c4oxdq32NS0j
 t24u8/ZnLpTMwV0h7iNVYh8hslp+0Ftb1AoGLT6AI0wHJ2M0OkzVEXPwif1Ra9IrDgp1de23ZGL
 988dzxttJ0R1rYMWMan8eDOc8+iRtrpciLCmnsoa8CDUUNfY5NGheodMreyWkpmImnLgoAVvt3m
 4xqkpA4WPQFHEuHGmAvc/2T73uWFE8KUN1dK9HcVOy3naaZ1wIWB9oSChF7WN0TolMOVTetx6K7
 ToSUvotGW1rtx5XbW6pDpe41G5N4=
X-Received: by 2002:a17:903:32c2:b0:2c9:bf82:dd11 with SMTP id
 d9443c01a7336-2daec646e99mr78475695ad.7.1788380305428; 
 Wed, 02 Sep 2026 13:18:25 -0700 (PDT)
X-Received: by 2002:a17:903:32c2:b0:2c9:bf82:dd11 with SMTP id
 d9443c01a7336-2daec646e99mr78474985ad.7.1788380304847; 
 Wed, 02 Sep 2026 13:18:24 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33256414c60sm497205eec.24.2026.09.02.13.18.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Sep 2026 13:18:24 -0700 (PDT)
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
To: Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Joel Stanley <joel@jms.id.au>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Paul Cercueil <paul@crapouillou.net>,
 Anitha Chrisanthus <anitha.chrisanthus@intel.com>,
 Paul Kocialkowski <paulk@sys-base.io>,
 Linus Walleij <linusw@kernel.org>, Chen-Yu Tsai <wens@kernel.org>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>,
 Alexey Brodkin <abrodkin@synopsys.com>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 Michal Simek <michal.simek@amd.com>
Cc: Ryan Chen <ryan_chen@aspeedtech.com>,
 Billy Tsai <billy_tsai@aspeedtech.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-aspeed@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
 linux-mips@vger.kernel.org, linux-sunxi@lists.linux.dev,
 Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
Subject: [PATCH v2 11/11] drm: arcpgu: Use devm_of_reserved_mem_device_init()
Date: Thu,  3 Sep 2026 01:46:40 +0530
Message-ID: <20260902201640.2024648-12-mukesh.ojha@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260902201640.2024648-1-mukesh.ojha@oss.qualcomm.com>
References: <20260902201640.2024648-1-mukesh.ojha@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: MKgOaCSMS-gnKbx1eM4NisqrgnDbwZbA
X-Authority-Analysis: v=2.4 cv=L+wtheT8 c=1 sm=1 tr=0 ts=6a988492 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=lEtn7xO9CsvGDZioIccA:9 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDE3OSBTYWx0ZWRfX/Qry7PwS7EZj
 ETvOW9t5sWrfqUSnVmmgayIzLe0ATuA5Asvi6e4M+ufARcC8B8clKerwOTQjNMcWod1ix44B4fz
 R+lwMHi8bvm40JK3Ve6BN+U7+OgrRPeRAxKeg628Ij0MyvXJxb1DGHmrDkZi7OV9y+5zeAO3dGw
 wUqjlNhyqm74PzInaC8NI9uTUtuwkBWVv3nA8PPFasDCw+koR7A0jU/aaFU1Nz+o5tsvl+DwRME
 itEz9NSe4GX0pTQyUwZcCexUiiIwF+q2Rx+En4GIA1A3eq4PqC+LS4Tv+Tru7zvkGbUhtJX/z+y
 6UrOJ6RS6YGpf1nDFYfd4bEEJdQRbrzP71tIyIqm7s2C1mY6AuNwNS8Z/uLWV78DNJlhj4Y4+7u
 SYzsnkEj2cBJlxh9xc9TDE/G/WOWrl+AGaKOAUBSeeD2o7BXrwRdF45GiHLftW8WIY535p3hfc4
 Og1MhBpogvdWZCFslBw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDE3OSBTYWx0ZWRfX8y0EUNzBJ1+1
 uiU9IRNRXamW1CQuylv8xcSpynaYR2AZ5HoNdFgHUi66M0g6QZkDZ5ytHFDa9SYiP0YlaH/bYvo
 E1Rf/PmRdscQnTFFlJDS6dGP5WgK1RQ=
X-Proofpoint-ORIG-GUID: MKgOaCSMS-gnKbx1eM4NisqrgnDbwZbA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-02_05,2026-09-02_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 bulkscore=0 impostorscore=0 phishscore=0
 spamscore=0 suspectscore=0 adultscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609020179
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

Use the devres-managed devm_of_reserved_mem_device_init() to ensure
the optional reserved memory region is released on device removal,
fixing a missing cleanup in the original code.

Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
---
 drivers/gpu/drm/tiny/arcpgu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/tiny/arcpgu.c b/drivers/gpu/drm/tiny/arcpgu.c
index c93d61ac0bb7..fa01407570a8 100644
--- a/drivers/gpu/drm/tiny/arcpgu.c
+++ b/drivers/gpu/drm/tiny/arcpgu.c
@@ -278,7 +278,7 @@ static int arcpgu_load(struct arcpgu_drm_private *arcpgu)
 		 arc_pgu_read(arcpgu, ARCPGU_REG_ID));
 
 	/* Get the optional framebuffer memory resource */
-	ret = of_reserved_mem_device_init(drm->dev);
+	ret = devm_of_reserved_mem_device_init(drm->dev);
 	if (ret && ret != -ENODEV)
 		return ret;
 
-- 
2.55.0

