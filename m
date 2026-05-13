Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 161D6CD4F24
	for <dri-devel@archiver.kernel.org>; Wed, 13 May 2026 15:05:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 71BFC10EF08;
	Wed, 13 May 2026 15:05:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="JpVZlKkP";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fhlW1LWo";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D6AD310E5F5
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 15:05:30 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64DAvgLv1393173
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 15:05:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 IYR8RcKCxI64ZndZ9Gltf2uR0RvOxYUzn4kE4pE8DJM=; b=JpVZlKkPnU+S+dFH
 bOoJdd/QMOrOb47PDDMq9YSOrqy//E9p2nF3flXO1pb02Q0NKJ6L3VCOEm02P4+0
 Z/NqwEKg0Tlz3wxHM4HYCQKWhUKGHDuXAd7IoSRJ2bawwCSiHQ3aFGEZsKNBRPA0
 oue6S41fMgJk7mqnEp9sZXz45vOlWOGHmv4R6Pit9gtPi75p6wTZOxSNZJSTuENS
 qre1imhcYG/SQs2g11XZmjuIGsyTuWQUaaoSEVVTaH23gxOUMaUfEpHiv5n9ZDuk
 jBBvfCYaIHO9WlGTuBepESfoJLiPL0GicoW4KYXGvKZ8nOW29/z+NHIWPcTujreF
 35ipXA==
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com
 [209.85.160.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e4k262912-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 15:05:30 +0000 (GMT)
Received: by mail-oa1-f70.google.com with SMTP id
 586e51a60fabf-42394108a90so11662076fac.0
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 08:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778684729; x=1779289529;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=IYR8RcKCxI64ZndZ9Gltf2uR0RvOxYUzn4kE4pE8DJM=;
 b=fhlW1LWoaS6FL2WcW/suwy2RvwYj6KpecyA3Wis1m7DEQCrRLoQ4iwMToSbmoM013s
 CuRfJKykJSI3CgbgP9avYTDK6bwZnk69o7cRUBtr2QRI3NKzo6BW3ztobSq71yX0WPF9
 y8qHLw7mF1npcRoYiqCPr6TsiOOcqp6fbzUfRuol7GNJzHm0jnY/m11ggifDr1XYl1XM
 MMgpWoRxIMvGvSYcq3mkKTaqNvIxJGgheruxBkiED0JA2K2k4Syvyie/UO/la7RtoCVI
 U8QwncNd/zshmP7rOLUd6jqt/DATHSW/49VqgzJ1OY5xLRQCH1P8x5iDjBWUi7XMVCzB
 M5JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778684729; x=1779289529;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=IYR8RcKCxI64ZndZ9Gltf2uR0RvOxYUzn4kE4pE8DJM=;
 b=KCt2rEVEaXbc4Hzz1nOJNFYXHTWe2Zn7MHeBtviBh+HthvE1ErsKKxIYbF3t9jostt
 2TlU6GuoXNm207S6608OHBtdqcOSL9H4JLOuwXsFNao3SJVdpEhLma1OXUknrPJgKrhY
 O84DNoCReAs9BdqH5WnfO0XvIpkDBDPSKbDhWbC7jbgTG+EAuzwK1z86hzeYa8peQ5fo
 Jk9kTpVc3kPbpWX1Vd/u4WaYfmJvXtPqV+yDOmB6v53NL6Cv0nbfBiChGh10FdTCOXZS
 +hRbjMOvVLnfJKGKzD+Hmq1501Rhcr8slVSUmYAd4/bXVnPBacKQ5uDzFkLHzPYj/d7+
 0e9Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ/dqrq/i645ALl5bHQo5uaL2tdSN91ZFIarMV6wZjVUTed8PhhmASnnv/FEMCW2BiQG7NyuAyI+IKQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyMiNgaKCwC8dhaFyWJERvr1eJmACG2kLREY2YItzeA/7bvxVwp
 PfAmU7FjFMxtLhuSc2S3auLdP1uXThfS8hf3o64uF3Z7BVA94NrdwysUgiyNeftXWp1WW4bnALq
 Tk65f2Nzzp56hRoW3aaNssTjD3m/UScOpk2epzBy124CHoC7Qjy1vfVulwKOUgmWrRSJwEIM=
X-Gm-Gg: Acq92OEbCx0CX8jBj5QrRuOL+nfoDBGhZlWV7O56go070ewIOyRVSwMY6yFQTnORL57
 g9NGiv4E2ggJ/V0as4i2r5ggme9aWtxWpgRIJ8hYAD77Hvh0cGHHRLxQ0X/hgj17TSzk6TSryui
 M0Wss1qW5p7vp52FAszuwBcwoNmJ53KLqm+FEMRg/3bVhZz2GUwo8zZWUBE/rx21MAhslvVgLdY
 iBOSNwn7EIr+Cw28Ur5QP3bW6SGjVAzdM2CrSxye/sjJPv4oZAxSvolph5kIiHbRDQ1CL4rsnYi
 s/pEIWoae6UfD76FgRgWw7kRXhm5s269Fbw0V+P73mTpqQejopDNNxc27KInQsLi8lol/eL26Wv
 5FwWooohP8o4UAW1MlGBZMkLCh2Qs+9MYPLhOENrYYoZtVQQqqw==
X-Received: by 2002:a4a:ec4a:0:b0:67e:3ae6:9031 with SMTP id
 006d021491bc7-69b7abb78dfmr1668974eaf.59.1778684729475; 
 Wed, 13 May 2026 08:05:29 -0700 (PDT)
X-Received: by 2002:a4a:ec4a:0:b0:67e:3ae6:9031 with SMTP id
 006d021491bc7-69b7abb78dfmr1668908eaf.59.1778684728905; 
 Wed, 13 May 2026 08:05:28 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:63ec:4acc:c4f6:423])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e8f542e56sm43216455e9.34.2026.05.13.08.05.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 May 2026 08:05:27 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Wed, 13 May 2026 17:04:51 +0200
Subject: [PATCH v6 4/6] driver core: platform: unify release path
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260513-swnode-remove-on-dev-unreg-v6-4-f9c58939df27@oss.qualcomm.com>
References: <20260513-swnode-remove-on-dev-unreg-v6-0-f9c58939df27@oss.qualcomm.com>
In-Reply-To: <20260513-swnode-remove-on-dev-unreg-v6-0-f9c58939df27@oss.qualcomm.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Danilo Krummrich <dakr@kernel.org>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Brendan Higgins <brendan.higgins@linux.dev>,
 David Gow <david@davidgow.net>, Rae Moar <raemoar63@gmail.com>,
 Andy Shevchenko <andy@kernel.org>,
 Maximilian Luz <luzmaximilian@gmail.com>, Hans de Goede <hansg@kernel.org>,
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Matthew Brost <matthew.brost@intel.com>,
 =?utf-8?q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: brgl@kernel.org, driver-core@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
 platform-driver-x86@vger.kernel.org, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org,
 Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2367;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=wOSsRJhHsrWDaQxuukzG68TWgsF2FASykc4TUq0RZFc=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBqBJMnejvUFHWQbuBgOnPq851u1BeQL054POyaE
 PiX1aFSZF+JAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCagSTJwAKCRAFnS7L/zaE
 w6SjEACH900P69OGo/t0IYyFtNg361mOg1F+/o4ing80rA1iSYnCBwJGeTzBybJ67UPhqiELDKO
 y+6v0W7ciSRV2GH7zFY1UnA0k1iOj7ZzX+wpcrsaqK9Svn2+LCq0TmzfxmFM+vmZBY2JFs8w1Gb
 Mbmz0rrF3p3WonLktt/h0sbAifNxzdRHdf6nN/Gj0sUdZX5F60oTWplpTb3aB+YnTHvAPivT2JW
 8ByJ+TMvwcTKOhSIbY16qR4eZyR+MPmz7jEbqsLJMnrzjaYaBtjY61gOO4cVTLfzVWPF9xdlOCi
 muheFSaISxM6ExIWfwU2G9vcm4Q/RniO/6H7lXWbLJ0RMXMzYLFX6k5oMb08VPXQKuHDUuKkdZ1
 S60kU69vsLj+gvMJ2o4EVXl8HySjRsUA2IM+DGdL1/aAsNwPWZ7D766NY0O6jFC4SjLE2jzI+01
 XSQnwA17xAKPppefhF8Lp3GujvhaC6VhL6QbyeXcPahJXQ0WJNMIaVhrgMQlXyYNs4EcKhZrpzm
 +MJmtFBqKRQTRNCQ1ipLO99TZR6iyymBynhNIhcOekuK7fpd0wRf9tPsVdx5i5nw5uxGBfWoY5x
 YP8MnUT6EU1+VsXeP+YBO1CvSntDHtyyUo2gtum+Ch/Q/SjZ5FlbDFLyVaiNx3BJig8nDhc0S9t
 JswpANlciNCBR6w==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Authority-Analysis: v=2.4 cv=M/l97Sws c=1 sm=1 tr=0 ts=6a04933a cx=c_pps
 a=nSjmGuzVYOmhOUYzIAhsAg==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=hkyMZWt8Xm0hL-3MNhcA:9 a=QEXdDO2ut3YA:10 a=1zu1i0D7hVQfj8NKfPKu:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEzMDE1NCBTYWx0ZWRfX18z0Xn7vuO6e
 N6gWARDzt54vYxiaU+UHuZ24+2fMhZ5qT4rXxHUtogB0Toi9Xe+HSbXZ23/BysUCgR8Got5OOzG
 I4NeCUnevLimtEP8qKp3S2N2q8e8TFvVtFb0+T/2NycLX8812PHlqr4ScONvFCQdK3uPgh+DZA6
 nhxT3yHE/2DMphLc1gZf0w1ZFKQf6FL1qlQoudRXbnRRqxT0ibHIQj8ArJ0wrAJyBSPIjOss+wY
 sP4JhdgF0hAIxJ5/0qivs5d0z9uWN4afZTgFQFaqopF/f2/gXaZpDUTyrGfs0jZxIEAnSzNkxdg
 dPBpx1S7NzAmaFPqH5Q0IQ7E3OyRxtlgIwTPfs50NAJciLbAYXJKwY5T/OaJ5vrMEATW0nzwjPZ
 YkW+dm3wuaUeQjr07ck+iQDw/lyQbJHEMIGHHOmqtOiFE6Inge4I5QLo0Y68xMg4xUopgAunJus
 xY+BVAHbflYUj0KNvqQ==
X-Proofpoint-ORIG-GUID: _R6rbf0q5bT0M0kfIwY954DcPZzxVnN-
X-Proofpoint-GUID: _R6rbf0q5bT0M0kfIwY954DcPZzxVnN-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-13_01,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 impostorscore=0 malwarescore=0 suspectscore=0
 spamscore=0 phishscore=0 lowpriorityscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605130154
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

With no drivers that manually assign software nodes to platform devices
created with platform_device_alloc(), we can now unify the release path
and remove platform_device_release_full().

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/base/platform.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index a19dd22deef2f3edf7cddcf824d02b4e09091852..22834be0a3aeabf538f57ec6815ab3cd6851c16b 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -599,6 +599,7 @@ static void platform_device_release(struct device *dev)
 	struct platform_object *pa = container_of(dev, struct platform_object,
 						  pdev.dev);
 
+	device_remove_software_node(dev);
 	of_node_put(pa->pdev.dev.of_node);
 	kfree(pa->pdev.dev.platform_data);
 	kfree(pa->pdev.mfd_cell);
@@ -606,12 +607,6 @@ static void platform_device_release(struct device *dev)
 	kfree(pa);
 }
 
-static void platform_device_release_full(struct device *dev)
-{
-	device_remove_software_node(dev);
-	platform_device_release(dev);
-}
-
 /**
  * platform_device_alloc - create a platform device
  * @name: base name of the device we're adding
@@ -878,6 +873,16 @@ struct platform_device *platform_device_register_full(const struct platform_devi
 		pdev->dev.coherent_dma_mask = pdevinfo->dma_mask;
 	}
 
+	/*
+	 * If the primary firmware node is a software node and there's no
+	 * secondary firmware node, the primary will be affected by the call
+	 * to device_remove_software_node() in platform_device_release() and
+	 * its reference count will be dropped by one. Take another reference
+	 * here to make it have no effect.
+	 */
+	if (is_software_node(pdevinfo->fwnode))
+		fwnode_handle_get(pdevinfo->fwnode);
+
 	ret = platform_device_add_resources(pdev, pdevinfo->res, pdevinfo->num_res);
 	if (ret)
 		goto err;
@@ -890,8 +895,6 @@ struct platform_device *platform_device_register_full(const struct platform_devi
 		ret = device_add_software_node(&pdev->dev, pdevinfo->swnode);
 		if (ret)
 			goto err;
-
-		pdev->dev.release = platform_device_release_full;
 	} else if (pdevinfo->properties) {
 		ret = device_create_managed_software_node(&pdev->dev,
 							  pdevinfo->properties, NULL);

-- 
2.47.3

