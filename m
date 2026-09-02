Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CB66C61DD6
	for <dri-devel@archiver.kernel.org>; Wed,  2 Sep 2026 20:18:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C9FE210F33C;
	Wed,  2 Sep 2026 20:18:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="DqM8xg8o";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fQoGFYny";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6239C10F33C
 for <dri-devel@lists.freedesktop.org>; Wed,  2 Sep 2026 20:18:02 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 682KH3mE2685552
 for <dri-devel@lists.freedesktop.org>; Wed, 2 Sep 2026 20:18:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=dWK2/qaA/kg
 ie630momcYQ5e7QWvw3Fh0xiIUnGJB64=; b=DqM8xg8oAo4+te9MVkPE+2hkAzc
 jz5r9PJt3nDNOGMwdU/VUpro8XOtp3eHfX/u8HVUvQbu0LWCEtcmP5SLJcrrGspl
 qazsvC3ud6osB0K9NzaAEcU1rjz6QqFJugx6i+mrKgjMZBnECm27NB35J2zRSf9S
 XRpbNtmaL3xkSniXibMGlZNpXp2wU9GMSD8oBDO+O6J/1a4xYS7frja/mRQD2adV
 vr8uhDaiq5bxg56VPEFx5qdC8a7xDrgaQ8Qq8lx3ghdriTlbu0dZFSnmhEbgKYmB
 ya0xA/vAO7hnVf9OUZWz3jWUwUoutjgPdxOR+DWuQPLCFALNsgr1aZPu3Iw==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gejv8a86u-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 02 Sep 2026 20:18:00 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-39533bb224cso2089442a91.3
 for <dri-devel@lists.freedesktop.org>; Wed, 02 Sep 2026 13:18:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788380280; x=1788985080;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=dWK2/qaA/kgie630momcYQ5e7QWvw3Fh0xiIUnGJB64=;
 b=fQoGFYnyaNLKar4qx2VGhufAzkTRbvv2D9oFZv/MONLcuuZOIHX3LfOrqBwBhr9h/E
 V6t+dTPLwfl+I+EWOVJODvm79KMOwPLCG75qIqzbZdh5LFi3hirDYbC9FsJ0zue/DE4A
 85FKabJoXmZQY+z1TZbbmG3vzrOfCgrItz6uBFxuYSCbkJN/vJcSMqyRK2YvTfNygSoV
 kgNGDKArPz5yVzr6Np7Rw3TEp9uR1SrnJycsGdM/NiwsssfuBeeeWtzflVDf0FFIfP5F
 sPEs7ZVyHVUYvXYC/gLvdLwwz1IUP02nAJlQ6LIvfXFilNyXSe3qNPcjzo/eXvkkmFeT
 BdbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788380280; x=1788985080;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=dWK2/qaA/kgie630momcYQ5e7QWvw3Fh0xiIUnGJB64=;
 b=EQ7Q1ioN4iLkwz+P/1zcTQNpOnYz5IlE59wzEZSzwbODoOEFN2hYwC60ktexKVctf1
 OL2uUDL94EPlK9BjUtbcV2MJ5uOD5MO3bhrzX4sSkV5sGtDKWjiFhcLESFH0f6CW3uNm
 6I+fXHOhYzQqmhdBQUC/SgTh6rHNyC2jWXI5FmCZap3DZrXuy+cPIjy+3mMi+tiSmPsi
 Mod0th2Q3N3IjeSNkEZkckjOEK4/EDdRyzfaBYFNR2AJkzFdx8jn58DmgzU+jnIRRfK0
 c3oV08BeTagoZWKsbwtyjgNKK5S9Tjs/7LUrHb9yVnXwd8GecZ9megPrCjl7nBSj1fny
 gbHw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwjTzkPabJTTPd4qTFx/9swVSXn52GfBQ/eF2IycKC9NsixHqfjWO2vi+qnsspzL1M2j2wHkdFOfVs=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lXRANEkE1MSJu7jvI3qu/QRULxxtA4Qe+djA+2ciVL9oBjMyKi
 7xE+QWTGprUaRYjHk1knzrYVh9alS7JbeN8lwAv0lSLKL/B3OAUIYKrJEmqqvDCTV8NK57OgTgk
 uuVaKB6kWxiFLsLpX3RaMJU928fkfND00Cy+GVV3h5kjxx/7EbqfPkojCQnPuM6P+kkIDS8Q=
X-Gm-Gg: AYBFou2AFpUenWJWOvqRNy91MFghfR4FqZJD6rg0rE9nr939d9j4GiHMGBjwncRm/vR
 Fgp+3CT1jFfZOdMJVSu4G5A181hojhPIEr1AGF0w/813xeEqdeEOijglzC/j9HjjjmBrgzDnmo/
 +O+d22VmbDZoux7zSTx9dTI2Ug0je152XA/anUo+YTDQ7GNKTJPWGsS70ShyRmM0vFuD76+Qff+
 vNY5Sb6HCgwh6wUbWfGUSHILx4/2yg7iSs+TzIgBX9tt9xi0WbmbLM1GAC2imrpekLA+nCc5uIa
 s2Dm+tyCxQq1r7aOtV1LTD2yWpclmI45HLrMYj9OkHGWHlJ/Or+Pp9hqN6xp4Wr34DkW7h10D75
 SczmuWUQxXfKRF1078x/fokQBEwk=
X-Received: by 2002:a17:90b:2687:b0:398:9c0c:7c71 with SMTP id
 98e67ed59e1d1-39aee1f9788mr12319142a91.24.1788380279851; 
 Wed, 02 Sep 2026 13:17:59 -0700 (PDT)
X-Received: by 2002:a17:90b:2687:b0:398:9c0c:7c71 with SMTP id
 98e67ed59e1d1-39aee1f9788mr12319070a91.24.1788380279338; 
 Wed, 02 Sep 2026 13:17:59 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33256414c60sm497205eec.24.2026.09.02.13.17.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Sep 2026 13:17:58 -0700 (PDT)
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
Subject: [PATCH v2 8/11] drm: sun4i: Use devm_of_reserved_mem_device_init()
Date: Thu,  3 Sep 2026 01:46:37 +0530
Message-ID: <20260902201640.2024648-9-mukesh.ojha@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260902201640.2024648-1-mukesh.ojha@oss.qualcomm.com>
References: <20260902201640.2024648-1-mukesh.ojha@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: hLzJvAAqOU2iH6Yo731afsLEsOIWuHN_
X-Authority-Analysis: v=2.4 cv=L+wtheT8 c=1 sm=1 tr=0 ts=6a988478 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=UuaWy5wPpgFSIu4BNl0A:9 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDE3OSBTYWx0ZWRfX+GJNiFNfJ2oi
 IAJAbdVCYIT2MQh9b8rtU94nHbkoPtFWoW3jrbVtdsBQYdJbZnVyXPdBuQQQfBWujcieTcYoYAn
 aYpfn82IQv5RSVYGC6fZezMsO717yHUtvrmbb6fzUDHiomERRfm26nCE/H8gY/VRrE9+jA9HJ/y
 1df0uddOwCCdX/Dy25dDMGVwmkGJqsS8lIuJEB5lIiOTS3cCwppcLfadBeAm5kzyumWHP2fo07Y
 XHbAAIhK7KNQIJzmjJHJF8csJPGrxJid8oQzkSKL7hWDIDkFPAH9d3tk7OiG4iP+60uz4AAOPFN
 gpds+SX8Zq//aLqp/9OW+j+XtLGxQa1EJpMmzeXgYEx1TBkvOjEsj7y+/tSmEC5tcZ8Y4/gKENo
 UGetW2Pqr2UQ5c9wSTFv+FI1Pn9FJ8/Ntk4gQjZsVnBMNhCV0Z7662OJ1SwiOvRqCyomhdthCjc
 1iKb32SFaTo4JqP2/FA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDE3OSBTYWx0ZWRfX3zkCtsVhG3gk
 DcQGwB4FierChTdAKEcL1VxyodY5AM6t41gU0YQy+/zqxYpj4sbNq0x2FS40SB5zolD1fSM+/hm
 OpXxm5bmv7yPM+t7cYkM9F/th5EeT1I=
X-Proofpoint-ORIG-GUID: hLzJvAAqOU2iH6Yo731afsLEsOIWuHN_
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

Use the devres-managed devm_of_reserved_mem_device_init() instead of
the manual of_reserved_mem_device_init()/of_reserved_mem_device_release()
pair, letting the device resource manager handle cleanup automatically.

Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
---
 drivers/gpu/drm/sun4i/sun4i_drv.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_drv.c b/drivers/gpu/drm/sun4i/sun4i_drv.c
index e9baca360160..c24f96bdd135 100644
--- a/drivers/gpu/drm/sun4i/sun4i_drv.c
+++ b/drivers/gpu/drm/sun4i/sun4i_drv.c
@@ -80,7 +80,7 @@ static int sun4i_drv_bind(struct device *dev)
 	INIT_LIST_HEAD(&drv->engine_list);
 	INIT_LIST_HEAD(&drv->tcon_list);
 
-	ret = of_reserved_mem_device_init(dev);
+	ret = devm_of_reserved_mem_device_init(dev);
 	if (ret && ret != -ENODEV) {
 		dev_err(drm->dev, "Couldn't claim our memory region\n");
 		goto free_drm;
@@ -125,7 +125,6 @@ static int sun4i_drv_bind(struct device *dev)
 	component_unbind_all(dev, NULL);
 cleanup_mode_config:
 	drm_mode_config_cleanup(drm);
-	of_reserved_mem_device_release(dev);
 free_drm:
 	drm_dev_put(drm);
 	return ret;
@@ -142,7 +141,6 @@ static void sun4i_drv_unbind(struct device *dev)
 	drm_mode_config_cleanup(drm);
 
 	component_unbind_all(dev, NULL);
-	of_reserved_mem_device_release(dev);
 
 	drm_dev_put(drm);
 }
-- 
2.55.0

