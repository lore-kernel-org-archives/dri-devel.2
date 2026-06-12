Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4500CD98D6
	for <dri-devel@archiver.kernel.org>; Fri, 12 Jun 2026 18:30:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 31EA810F60F;
	Fri, 12 Jun 2026 18:30:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="fFyj2AKo";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WeDuU5Wm";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B6AAC10EB0D
 for <dri-devel@lists.freedesktop.org>; Fri, 12 Jun 2026 18:30:25 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65CGVotc4113371
 for <dri-devel@lists.freedesktop.org>; Fri, 12 Jun 2026 18:30:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 49OPqlKhqHIeEAhBZzcXi+3lZ4PA+n7d2F3AhuDo47c=; b=fFyj2AKooKHoOJKA
 NJgTtdivW3JLm+klRZc4PpTlm1VQTdUOBgkHjpNv+opgjkfzFCbs/xXVHNoIb8IP
 tIY4D0YKYKra6h+5juTT/O0WTaHR67EJ8J9eZpI12fu03EjveSnXBiJXWkJnotN8
 BdHxG7ipbukle14/tTq9WSiXQCQUTi+u0CK0zUnFql52yCXNdoNswkDV6/5bc4w3
 3cUFwu5KE94MOEUlr6lGn10HTuHcGo+wfQfcqerphjxnbSWG7LPtvgR/XM5w+7vZ
 D+ZXrEgYUErJiDyl2MUJrkd4VornswnCb0xo0hjn6So7K1550uobZwDtjyCuJpC6
 oR3wgQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4er30gc2nw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 12 Jun 2026 18:30:24 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-915f7c37734so287028785a.1
 for <dri-devel@lists.freedesktop.org>; Fri, 12 Jun 2026 11:30:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781289024; x=1781893824;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=49OPqlKhqHIeEAhBZzcXi+3lZ4PA+n7d2F3AhuDo47c=;
 b=WeDuU5Wmp4zwK0K2sEmfKOw47rzScO0aJFKEpiXYu9uuQN1LHyg9vx5YH1KjhEhXP3
 0kwuRUn1xfy0GD2iace/wRnPlqq0JeBWu+K1eLBBvmSLgHbwhvVFhuuczwCUjkLhVY8J
 QWClvvc1ZoUzOq28nlUPb2ierKyBwuUDsBnPZsJRap+JLcOaE2Y3yWMtKRBK2KhfvERJ
 JsGexio3Qt7S7hggxqoFaV4+JQ5cBG6ddH5917b89sE/bX2qByn4BSEjj1j4xMRAk7de
 Kuz/10ldVEFZcv0XCHzMJ4Kuh1SPTz38tqjGzKmEmja8S4wkBwCoywkcQc24RgzY5NM0
 HoDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781289024; x=1781893824;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=49OPqlKhqHIeEAhBZzcXi+3lZ4PA+n7d2F3AhuDo47c=;
 b=MDU8DJoEAq3WT0gYbGkiJyyMK0+hKZZ+Y4hO/T2W3kyiZDKat2mIjZOw682PVM9nRQ
 BWwfzde607vSlxRzwhkdqYhiDLXY4nuvCzszEA+ERg2WmYgQ1fQXy4rM+fCs0k9iaw+R
 b2Rp2ngNAu2ZafLSOE1lbgIDxDWi6VEa/k1Ytd5bMq9d69wlT/o05GrLI15Nxtc6JAEc
 Fhe1yLZUjxY5oWqDyjS61ES0XZb7zzg+wfU5kKlIjrULbw87L1Yra6xzL24T+AsqmuJh
 /tdSQrrE0fPG57gSpBpNl8MCxNddFdObhx7yM8fdkw3WKGkVnEzbL/U13N3JU4tqEibe
 lCEA==
X-Gm-Message-State: AOJu0Yz/OkS7ZPeNWX74OltRVGvvkvpVhl5kQUAGOyvAKJpDLhFR07xO
 bJ7yS8SOEDbv4MbrT+Yk9/Q34FdnAlw7mcT1oP+YTBS6eTX59zAbgd9TCupepSndR0KyKg+vuNA
 SqhofYJ/b/nYw3+IewZYmvi2IYm6vdT5EfQiIt1TOsXGx2bcvn4gjVZt/YIDq8S0YEfs6Rn0=
X-Gm-Gg: Acq92OFjuDZ/ogsLNlMPWBdwAeaWPCeYg+zGstQRfz8qNseFRkI+aDVQm3wdjZdnTNv
 vyh/mG0j8HULAmib9R6GWrICVCnYZmP3HYMHLnIU1JoJK2FBaadSbOYWHN6artonDqDHGiThOv4
 vNxzajJXLtXrAhk4zQGkvU0L3GLzbuG/qhmzmQ8UfUxFDvX9cqjUYKjEKSBiScMf8EVdTT1JZcP
 Q3RzjIelC1YfZZQeCWBSqcCoK2/QX+9BNHM/jZ35HIId4KPUtQm2InFvJ8YK4f3UvNvr0gFdbeX
 7HMGe6j20Md5IlwjcrUtXWGmoC5DAHArVx/yTxacEYwAtQmAHOd30ps5RiEh7zQWHoZxI/LhFjj
 gEC9S00VFXRWhLOr6/AsSI0DNG+CDFGe8SWazwrqwteanEL3HJrhUJFHtYYSpag3WOgGVfGbbLw
 wFe3Dl4FI1MDOQ5/dYOWLU16qhOsFHOj00vDg=
X-Received: by 2002:a05:620a:a0d2:10b0:917:fcec:cfe0 with SMTP id
 af79cd13be357-917fcfc208bmr80223685a.33.1781289023489; 
 Fri, 12 Jun 2026 11:30:23 -0700 (PDT)
X-Received: by 2002:a05:620a:a0d2:10b0:917:fcec:cfe0 with SMTP id
 af79cd13be357-917fcfc208bmr80214285a.33.1781289022999; 
 Fri, 12 Jun 2026 11:30:22 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5ad2e161fefsm742173e87.8.2026.06.12.11.30.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jun 2026 11:30:21 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Fri, 12 Jun 2026 21:30:12 +0300
Subject: [PATCH v6 2/9] drm/amd/display: use drmm allocation for writeback
 connector
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260612-wb-drop-encoder-v6-2-9f3a54f81310@oss.qualcomm.com>
References: <20260612-wb-drop-encoder-v6-0-9f3a54f81310@oss.qualcomm.com>
In-Reply-To: <20260612-wb-drop-encoder-v6-0-9f3a54f81310@oss.qualcomm.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Liviu Dudau <liviu.dudau@arm.com>,
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
 Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>,
 Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>,
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>,
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 Alex Hung <alex.hung@amd.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1809;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=hLu1cwKI2bwQjArWh6mX4nFC7KW8Gok04gwgDGIykRs=;
 b=owGbwMvMwMXYbdNlx6SpcZXxtFoSQ5ZOgNlx2RvH1rmncgWo3DgW+vltmevq93dm7mxf+Ev8u
 rbv61fHOhmNWRgYuRhkxRRZfApapsZsSg77sGNqPcwgViaQKQxcnAIwEbuv7P/965vCjkxfXj1Z
 UqjpR6ueWrD5vk8ixa0SSz5WMc8XTdxVdIpFd45lkOOtyH1s6ZwvigtCTzD8fhQZfGuZeX2NUCq
 jmUp84FsuuWjFjMrJO77/tTW6rmfIOl34nbv22bvT7/Dc//0o77D/+iLWy91JDV08gkb6s9lfTW
 VNm6U5rWI3x6HVK/ReKMvapE1RNnNg+CSurmvqGlGnONeQZa6/z4+jq6umiH9n4PvAu5/3Q8KN1
 W9MOYN1eZLy/2icMarpbZNht9+lvoApLGfRMod9v/TO1drvk6y2Cj3qeNzSJHICi9vs7BbRTRoF
 aZuU0ta+m+y9gUWj4lbMr8edy14G3DWIM5qz+Ob2RttTAA==
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjEyMDE3MyBTYWx0ZWRfXzbsrcU81noTS
 rEzShAP86GcPA6K/FSvRHacWp5XvHvJcEE7UbAvItjMxNGRsgymJ1JoW8Bcw9SOCOeDlWrcWYPi
 I/B5dlH9Oon50qXqiiD1VyIr37HJehk=
X-Proofpoint-GUID: utmmpAoah2bCbb6TX2bLh7lEH-IroKVz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEyMDE3MyBTYWx0ZWRfX3/Sc/oEzaVqc
 YPyF4J/E50PKSa5vpDXRBhaVbVyq8Y2o8NVxJA2ctaA6gEXkbVkm6iGP4FVwlqhP5ovsQkd6H4Q
 4mD+uG5ygxvRT5lao/PhCttaDqD5gxXzgId92KCbN5CTE6Rl3irXQ/TtrRJErb5Hsu1NrhlLwP+
 BT7X8dh4d8wLJ2YG+IdtRj+37JrWXDI4HTUjMelJWb/WNxfb1wVpOIwVe5NLycjCFfHwFYcSuvH
 6r7vuSEfLbIybv79ZJmY7kMdVDELBk6Z+urczE7cKvV/AGnZjkixnHKDMsRgyz/FLkcx4aGDqKD
 0vnVAJ9ASFr7kcr2sJIZZ29inp4q7Ng3OOsJc+0qjZFiEWeFqIcfmuj+xnNDjYNfIjMOEw1PXbl
 M/J99F88pNZKm8wCWD7jiUimyEhYXSSKmzTQxnrK7dFQjKI0TtMf22Njh0maK+77tLPF4BOCRD/
 sETuZOq0J3kTKZ3/GEQ==
X-Authority-Analysis: v=2.4 cv=evnvCIpX c=1 sm=1 tr=0 ts=6a2c5040 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=zd2uoN0lAAAA:8
 a=EUspDBNiAAAA:8 a=6a0IvY6ZUD0qJKO7u2MA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-ORIG-GUID: utmmpAoah2bCbb6TX2bLh7lEH-IroKVz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-12_02,2026-06-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 bulkscore=0 priorityscore=1501 phishscore=0
 spamscore=0 impostorscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606120173
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

Currently memory used for writeback connectors isn't freed on driver
unbinding, leaking the memory. Use drm_device-memory allocation
function for the writeback connector, making sure that the memory is
freed on the driver unbinding.

Reported-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Suggested-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index ece581609cf7..436562e32e63 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -91,6 +91,7 @@
 #include <drm/drm_fourcc.h>
 #include <drm/drm_edid.h>
 #include <drm/drm_eld.h>
+#include <drm/drm_managed.h>
 #include <drm/drm_mode.h>
 #include <drm/drm_utils.h>
 #include <drm/drm_vblank.h>
@@ -5807,7 +5808,7 @@ static int amdgpu_dm_initialize_drm_device(struct amdgpu_device *adev)
 		link = dc_get_link_at_index(dm->dc, i);
 
 		if (link->connector_signal == SIGNAL_TYPE_VIRTUAL) {
-			struct amdgpu_dm_wb_connector *wbcon = kzalloc_obj(*wbcon);
+			struct amdgpu_dm_wb_connector *wbcon = drmm_kzalloc_obj(adev_to_drm(adev), *wbcon);
 
 			if (!wbcon) {
 				drm_err(adev_to_drm(adev), "KMS: Failed to allocate writeback connector\n");
@@ -5816,7 +5817,7 @@ static int amdgpu_dm_initialize_drm_device(struct amdgpu_device *adev)
 
 			if (amdgpu_dm_wb_connector_init(dm, wbcon, i)) {
 				drm_err(adev_to_drm(adev), "KMS: Failed to initialize writeback connector\n");
-				kfree(wbcon);
+				drmm_kfree(wbcon);
 				continue;
 			}
 

-- 
2.47.3

