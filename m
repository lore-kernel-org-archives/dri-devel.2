Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2688810F2865
	for <dri-devel@archiver.kernel.org>; Fri, 27 Mar 2026 19:50:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6487810ED10;
	Fri, 27 Mar 2026 19:50:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="BY41S+uP";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TnOoCO8/";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E802310ED10
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 19:50:27 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62RI37841010699
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 19:50:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=Joyat6xY8J/2wBJuh9dkzc
 VpshZDJVBXgu1u0SsLOvA=; b=BY41S+uPImkV4GDrpyEju43ytGWQfCV9nnIbYA
 2tFmMFxPWMdHQMWr9evHx7aGNXliKTuus+y+FwMoPTFoni4b0gLHnaZvH8Ter9Hu
 hzAufsf1Oc50qmXmsvvuqIIPts+lZjy+ZcpSHqJ4fGzBd+RzLOUACXkTfgy7M4bX
 WylVgKdHn/SU9DAn2gSkUbYgabn7jFEr5qLqshjVlMydOZnYDZFM6/p5z73kxycR
 4vWZ/Oy7D9OWscfldvs9kJQGYFvYQdLmZwiYqo1txUhVXg9NUNpZ+GBb6QkmiX2d
 u5TCmrMNH0FeIBF/d+eoKfnEfmnV2eX/ZNGVr6xl+6TBzDHg==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d5hapuhu9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 19:50:27 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-50b781542c1so57789831cf.1
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 12:50:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774641026; x=1775245826;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Joyat6xY8J/2wBJuh9dkzcVpshZDJVBXgu1u0SsLOvA=;
 b=TnOoCO8/EhGTomqeSpTttZgbQv6rRmYx4Z1iFkt2qwf731qAYaBSqPVk5UjbJo3761
 9yJCrapXSuvh8j5Tv7HzhXoQSiErZOyM+49Xj0iDOzc+XyGZV2nZkBnzz/grV4lsTZLk
 fBh37ARg36XbUlce2lhOYmN+6i6Vi6yyLC6yq9XPfandG2++0JXXngN1AXxEQJt2UCIV
 VrOHVHg450bSWc/cxhHxuGArJxsuqmqQueOiI346zAeFFGCLHYtsW6RBHZdSC4Fv83oB
 lIzfX0d01SCijZvs845bHOwzFcD70WriEPowgw6mtDnBo9vhzwQFypf1m6r2AmIwjSI8
 bJoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774641026; x=1775245826;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Joyat6xY8J/2wBJuh9dkzcVpshZDJVBXgu1u0SsLOvA=;
 b=G5SFNrOOGA+zrPylun0hMp7l+SR++BUzaCabfPpvFYLKLRO8aWH/tqM9hgOCusrLkE
 8095bq0hefOaCo4G3mTfwx0Zqq4beWxIX411vzsFf3hvm9cMcSupBu1N1jO/QAj4Ip4b
 5xqCZMv4o24ff432kQZ2sKmKO2a6f6LYTFRnXUl9clXcphIDZAy5xLIkNo9yZt6JEB0d
 e/d4C7/hgjscU0SX/0ELtdYQAAdqGIBXYqZSJnVLv3yJmZnRs/kHrpDUo3hXdOJqXkjM
 z0Lz5gPWOxmSaXAbi2MEgsEYLhe0nX7cqqv43zlzSs89a1AW+Z37vs6xZEbNrXrYPcKB
 f3zA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX7KtQRQKC0dGc7KPLhFluhwLLjIX0pBUcYTKZjJrlYd21wQkqd2Mx1SFucwU1WyxPyYkUtsRKV2cg=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxL5IGX1INjhkuNTQ3Tz6iPZi4LsZ67jmYiyvlP4cnaIB0Q0cOd
 9C2tev/Lb6mC0ostTIqoAgXTmHDC8LX5kUa7l0+05A8oWTR8ZvmZQzeFyfXkb5TEIjaqWTzWHh2
 PjrnbY/2i7zyByPFJfAqIUamj1j1fxZaWAbW8LcEFXDG/iocfut/31MkSBLJHXnxj5RUWVOY=
X-Gm-Gg: ATEYQzzNEPez9uwYEovolcbOtOqvIDzY+aRXcw6Eb2rBR6XwUr2ywIA9gxc2o03X3qR
 eF/zleaKGjUzMxe0jIre+JJuvKRtPSCqzD4BjHftZw74A862uHMugFLE/K3tZvdqn8YOby5OjaQ
 jpJp4kLM7wtBYBsmE8pLYwH7i1aD9w+03VmL6aJyFI9w/T0kvWh0rlZ/U8sKi7erQJVQm/zqt42
 zgXRMyM/JhMril3Klo+clwj4fsDKaEpU7PCxLiHp8SFx79AejaPtYRj9eqH8mTuKQ+UOFRIwKAh
 VPtLcNqk7Vq5xSOiFou+kA9FT0BPefqO3mxAKroavqlbWC1NxnCqkyR+pBn9yOKz69JsPQVSVet
 4saV3Y9ODn7IVF4+2IpUzcZvD71XN8GbSUjE6pYsxD8+uhA6Siu4FbXBFcOUqFJd6U9APXZOjt3
 EdBvHJbc6INHZQpIQOJWprZgLSFM9eXeLKFmgG
X-Received: by 2002:a05:622a:83ce:b0:50b:b32d:b55c with SMTP id
 d75a77b69052e-50bb32dc772mr3025361cf.0.1774641026401; 
 Fri, 27 Mar 2026 12:50:26 -0700 (PDT)
X-Received: by 2002:a05:622a:83ce:b0:50b:b32d:b55c with SMTP id
 d75a77b69052e-50bb32dc772mr3024941cf.0.1774641025879; 
 Fri, 27 Mar 2026 12:50:25 -0700 (PDT)
Received: from shalem
 (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl.
 [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b9b7b1a6736sm7031166b.38.2026.03.27.12.50.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Mar 2026 12:50:24 -0700 (PDT)
From: Hans de Goede <johannes.goede@oss.qualcomm.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: Hans de Goede <johannes.goede@oss.qualcomm.com>,
 dri-devel@lists.freedesktop.org,
 =?UTF-8?q?David=20Santamar=C3=ADa=20Rogado?= <howl.nsp@gmail.com>
Subject: [PATCH] drm: panel-orientation-quirks: Add quirks for BNCF NewBook 11,
 GPD Pocket 3 and 4
Date: Fri, 27 Mar 2026 20:50:23 +0100
Message-ID: <20260327195023.774338-1-johannes.goede@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=TqnrRTXh c=1 sm=1 tr=0 ts=69c6df83 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=20KFwNOVAAAA:8
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=omvOJE7mW8HYQ-0I4PIA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI3MDEzOCBTYWx0ZWRfX+ANZxrPKBgQy
 S81gSrHyYYJ8zRsMqCjHZ7ts+h2uarVXqk+J/jIyMl0zP4kuGIb+0brCUkkbb92HM5kHGan4JhB
 bxVtFrwluCvqdwKc0MQDd15VfFlIBLqcB0ju2IbBihqA4tmxB1VC/1d7BmotLVQy+TgZnavUxQV
 463jGJmhQFtmIRS9qfNnhGNargJGmm0ezr0HwsLgxP9zj9KvE2P6+Rvfu3yl0ldVrd9h75b2+5Q
 A2Mo8HRwTxQ0tOEcYx3Hk/urUj58rlE6F5iF3pROUyx7QszdXYY+rSksoHaV3d23yZe+vf5qKu2
 ELyjuBAXuQ/a91vxe4EDJRrAhqFcMFcZA/di0pAUETUkI6pMOLu9dQoNojw3NzKuDd1NWOZmf57
 2Q6gXmEfY7foemGYbNReDvnKuk4cNfdD9Cl+ELpfVwxh2tldTNXfQxZtNaZPHJKaWjxufbD2g+8
 eVSNMdvVk+pDlGnKxEg==
X-Proofpoint-GUID: ac1dGABGwZX2GduJSS6hq1cFBtODBBWR
X-Proofpoint-ORIG-GUID: ac1dGABGwZX2GduJSS6hq1cFBtODBBWR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-27_01,2026-03-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0
 malwarescore=0 suspectscore=0 adultscore=0 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603270138
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

From: David Santamaría Rogado <howl.nsp@gmail.com>

The BNCF NewBook 11 and GPD Pocket 3 both use a 1200x1920 portrait LCD
panel. The GPD Pocket 4 uses a 1600x2560 portrait LCD panel.

Add DMI matches to correctly rotate these panels.

Closes: https://bugzilla.redhat.com/show_bug.cgi?id=2448915
Signed-off-by: David Santamaría Rogado <howl.nsp@gmail.com>
Signed-off-by: Hans de Goede <johannes.goede@oss.qualcomm.com>
---
 drivers/gpu/drm/drm_panel_orientation_quirks.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/gpu/drm/drm_panel_orientation_quirks.c b/drivers/gpu/drm/drm_panel_orientation_quirks.c
index 3a218fb592ce..693de83ee211 100644
--- a/drivers/gpu/drm/drm_panel_orientation_quirks.c
+++ b/drivers/gpu/drm/drm_panel_orientation_quirks.c
@@ -269,6 +269,12 @@ static const struct dmi_system_id orientation_data[] = {
 			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "Loki Zero"),
 		},
 		.driver_data = (void *)&lcd1080x1920_leftside_up,
+	}, {	/* BNCF NewBook 11 */
+		.matches = {
+		  DMI_EXACT_MATCH(DMI_SYS_VENDOR, "BNCF"),
+		  DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "NewBook11"),
+		},
+		.driver_data = (void *)&lcd1200x1920_rightside_up,
 	}, {	/* Chuwi HiBook (CWI514) */
 		.matches = {
 			DMI_MATCH(DMI_BOARD_VENDOR, "Hampoo"),
@@ -330,6 +336,18 @@ static const struct dmi_system_id orientation_data[] = {
 		  DMI_EXACT_MATCH(DMI_BOARD_NAME, "Default string"),
 		},
 		.driver_data = (void *)&gpd_pocket2,
+	}, {	/* GPD Pocket 3 */
+		.matches = {
+		  DMI_EXACT_MATCH(DMI_SYS_VENDOR, "GPD"),
+		  DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "G1621-02"),
+		},
+		.driver_data = (void *)&lcd1200x1920_rightside_up,
+	}, {	/* GPD Pocket 4 */
+		.matches = {
+		  DMI_EXACT_MATCH(DMI_SYS_VENDOR, "GPD"),
+		  DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "G1628-04"),
+		},
+		.driver_data = (void *)&lcd1600x2560_rightside_up,
 	}, {	/* GPD Win (same note on DMI match as GPD Pocket) */
 		.matches = {
 		  DMI_EXACT_MATCH(DMI_BOARD_VENDOR, "AMI Corporation"),
-- 
2.53.0

