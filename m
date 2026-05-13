Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C35EACD4851
	for <dri-devel@archiver.kernel.org>; Wed, 13 May 2026 15:05:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 31E9410EF06;
	Wed, 13 May 2026 15:05:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="DOwwEpAU";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Y320GJGw";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8A73F10EF0B
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 15:05:22 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64DAWDQi2321248
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 15:05:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 aSJkUW3sdSq9NIEJuMhwmsrLO5ZZJ71MntJqYUHfhdY=; b=DOwwEpAURofCdVa7
 yv9NCVkgVXf6qOSXWpoJOH/2S03kgX4XgnyWYb2qvUSF4JjAHww/oADGgpxMaxBu
 YKzJdMhp4NOo+2iFX0sVOdAHZk50u08fBqWNesmNVX7wSvo3V4Ni7yFnlwt1uruH
 w25Eec0tpCjffLBEZIfRbNW6gCBEux5x+txW/k0l50OCBeP5GhQ6D/ul2S2PWAHx
 i0Zd1o/t+gGXPnd3DqMMvZ2QbC/ZIEOgajsrH31T4GgkLxatRBnqrGxuHGzV6dpb
 cLlph7q0pKUsGwMEae+ChC850z142pZv42PdEOW2TWEiJ7W0wsAvWYcVs3hZAoyN
 bhrGew==
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e4hguam0w-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 15:05:22 +0000 (GMT)
Received: by mail-oo1-f71.google.com with SMTP id
 006d021491bc7-6961163ad6aso12631787eaf.1
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 08:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778684721; x=1779289521;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=aSJkUW3sdSq9NIEJuMhwmsrLO5ZZJ71MntJqYUHfhdY=;
 b=Y320GJGwjumBC179Xs7rU4hcxUtqtLH2M49LJz1KzAGTBpGVlwQrNFtfn5oWgwLTyc
 iGY5rZRWidNgHdBBj/bV3kLtB/zmkB6KtQmXpcIcfjWMRrrZ/fMp7Gdf8dNSoTNrlQlN
 cchX4ipcqmHKqst7nbYx9ZMJc1fxRq/nHG/OvU21nPbSZqygq1xpf04bqfjgb4AQAuvN
 0a1yq3guUEEU5A3dY3dzcNNknLrt9rM7oACHVohIQ2uGMPXB8+tk1IOku1z7IJNG0SS+
 YtCWbI3/2WJ0xQfdgcLP/x/B2590RTbnY2uF2x5GZS4Mi7pDa4/7AmVz7Y4dtUPzhQZu
 n65g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778684721; x=1779289521;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=aSJkUW3sdSq9NIEJuMhwmsrLO5ZZJ71MntJqYUHfhdY=;
 b=ARmVA0yGJYnQcCvT4NTOc0+KdeSDeFnDQXM1ijMBYmhAUlEmE5UMBhxhFByITZLWBg
 XpEHA0EXgzX2xDVSeUtUG940MUrtUehv4GCtIXUAkLtfe05l/QQl+k+IQfbQ0Uh0Yb3f
 sMZcPrC2O8TQy9DHnYxxEzUiJtbjri6eYSmhoPFmkrZASTls0f1xY1+rExSwRvJa2oOa
 zUfNUw367X7Kdv1+Q6LAjN5hElOOCKPpr9NxZBb+RbQCdblco4ryCtuPv5q21T6uKN5v
 Sbin7rSv7ZB3k02sMAblUyIRQGWomsq3jIfLzOMDIRpafRF51hQNPWRbI1Nm3YzyHI95
 twTA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9GZ/CcgjmnNhTk2EvFHaFaDei0Wh6TQAtpGBFRt5s+Uv1nxDHtQFXW7ZpsUF5gvJnz+QXZCqg28CA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yzpr8NslgG6daaUh/diduj8S725h+3tSqnJryabACeLX7/GTCh+
 NPwtVnnfoY4YKf4VgQvh9PQRVPuNa59SdPSRjFdDMx2ETmOYNabANVx9zwfI5jmVAv6T8RagW60
 acqeunz2z896VrJGi5Ze2Lleejo7K1h5DNF80W112byBwlj29RP7s3qcnVpdbmrAfyfYzpgQ=
X-Gm-Gg: Acq92OF0dNL0Xj+d2dCAGgxHOuOJHMG6JmFoTCSqx/slbCDW2cRr54LvydjxOtwhh5o
 kFEL1xXGerZwffmFVLVayaWQ9ey1cOlvoQF+cr9xXW1MTgzEVzXBh1fJ6JlWDYnrsr+iRXRuFfb
 RtLR4ejRJ4AsU25s5zTphTPB5osj4WfBXtY6tA0j5mZUXVBwt+iMmUr+BCN2f1f0eZ2Sz4CXlhK
 Uh8YSv3CARI8AIFOVuaOn4pPjifL4/Oa25C2KBOFg8ei5lUr0/EVawlqwhaKx44gNAZUxqzRWiG
 24cgugp/QO+8REwCzHSZABHFZZ55rrlmogL06XNHX/K5pI92qW4UNWXNoz5d3/oQor+PYdPoJMG
 HN9S3tX3KuamvRRXfo3TYLk7dV5GKUhdVvTwRE3HyY7MKC5t5bA==
X-Received: by 2002:a05:6820:c88:b0:694:8646:9927 with SMTP id
 006d021491bc7-69b78e151e3mr2067600eaf.35.1778684721173; 
 Wed, 13 May 2026 08:05:21 -0700 (PDT)
X-Received: by 2002:a05:6820:c88:b0:694:8646:9927 with SMTP id
 006d021491bc7-69b78e151e3mr2067515eaf.35.1778684720539; 
 Wed, 13 May 2026 08:05:20 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:63ec:4acc:c4f6:423])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e8f542e56sm43216455e9.34.2026.05.13.08.05.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 May 2026 08:05:19 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Wed, 13 May 2026 17:04:48 +0200
Subject: [PATCH v6 1/6] driver core: platform: remove software node on
 release()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260513-swnode-remove-on-dev-unreg-v6-1-f9c58939df27@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2612;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=7CT4RdGd8vHFfi08UzdJ0gY35hkIPSgc6GixhOhNOoI=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBqBJMkJrAnP++rExRYyFuP5VzjyttTtBK61XiAG
 qYsTM0aNsqJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCagSTJAAKCRAFnS7L/zaE
 w0NWD/9o1//pvqg5ealCNkdfHJIPPJ6KIzTFVfZcoQZkGuENeQrqew8b+WPMREwuJ4xBgI4CLLQ
 oj0RVbrq1WJWkko8JaB0R9SQozi89OM70fo0x8TTnnvW44nRU0fo8p5spqLpj9hDG2hSBCN8i5X
 Y4CE3pwLZU7M8YSi4jN4YLlqYwV3UtIUHZjqvbL1Vd3pnYuq0N1rsA8U4WI4VhJL2/kakNQtDv7
 EJfPiV27idjSLXytXpEhlnxqvPNWD2s4Gae4H434lcYMMbTsBFKx5I7uo6yojfzlZPtdchSmzxQ
 DqM3xOEFN6iKDe6LHPgrvZKMyoowXe01Vvn/T3VwM1oL9c8+rJ1NwEUOylUBhHBahbEy9a0SuL2
 IF7MaqQwWja7QmqnLtwJvspsHg4AeSeA5Fq+baGppBDhsQUHOJUrtQSHAuEoRGgAKV2/Bdq2aKr
 Woej7bGcJ7aY2AkjYr3Eb/FsquzqyNqzeAooPsCyRi7Cs9Llg6DiQ8O0Os1OWTG+DrykGJSuo8s
 K79MWwTkOo9pYyCnsEPWhso0obnhHYPNQFPydT/EzrNTy/EFB8Vio3gy9kekzTIAdArk2tIC4KY
 IYdOHa8BaXqWHKL0uFRYc4Y9nQtF2r6rFoFIAY54ShSFFMmdZIEeHZFei9BPrc5XWYuwtxTiJ9u
 rYGfdQvm02e+g2g==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Authority-Analysis: v=2.4 cv=X4di7mTe c=1 sm=1 tr=0 ts=6a049332 cx=c_pps
 a=V4L7fE8DliODT/OoDI2WOg==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=C8YuS1gbLiBEeSI6bHIA:9 a=QEXdDO2ut3YA:10 a=WZGXeFmKUf7gPmL3hEjn:22
X-Proofpoint-GUID: OMf1FLqcXfKhxBXSLOjoQ0QuXlPPQmiQ
X-Proofpoint-ORIG-GUID: OMf1FLqcXfKhxBXSLOjoQ0QuXlPPQmiQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEzMDE1NCBTYWx0ZWRfX5vWTjsisURP8
 wbPwxXnCXsG+gaY5nnOBt21TMcXfv0f/MvBxj+vHi1GdpBWsYs0Hpv2X6sxcruOJPJiShLhV0+e
 RYdaVjD33mbDdVNRqUuFl8ex72riUPn3nBGO5qbTac3u34lwf0wAxB8gDa5fRIyP14Ink2i0x7d
 GWw4vF26ZB/B58oeTANqkHOCGxPXKYXs4EcwydI9PxI49DMr8F+AZKElYOIIweDdvyAPmhRf4HU
 6gRwRjQtYwe5ERbmpckcCfFpxADkyJtqcOaKsSzPGQ00gBUDR6QbqXWWOnKcYX+9sldxCa7MFJ2
 VK24KuYMTCilw9jjNduCwM7dXhO0g0cQbeqTBq0FcIoBgPtH6p/vk+kT+Sx+BnxeOgXBfYfECZ5
 5H3BGIpJo+XMYYNKTmqBZ7sAcWeu1HGfgXKSM/lUDttgP0Z7kGK74+DYc0FPECMARRqMeEu09MF
 vD/aRTFMjy3xTpERbLA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-13_01,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0
 phishscore=0 malwarescore=0 suspectscore=0 spamscore=0 clxscore=1015
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2605050000
 definitions=main-2605130154
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

If we pass a software node to a newly created device using struct
platform_device_info, it will not be removed when the device is
released. This may happen when a module creating the device is removed
or on failure in platform_device_add().

When we try to reuse that software node in a subsequent call to
platform_device_register_full(), it will fail with -EBUSY.

Provide a wrapper around the existing platform_device_release() that
additonally calls device_remove_software_node() and use it to replace
the former if we end up adding a software node.

While at it: check all three possible situations in which two software
nodes for a single platform device can be created/assigned in
platform_device_register_full() and bail-out early.

Fixes: 0fc434bc2c45 ("driver core: platform: allow attaching software nodes when creating devices")
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/base/platform.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index 75b4698d0e582e67adafa78c312d75c72fd654cf..a19dd22deef2f3edf7cddcf824d02b4e09091852 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -606,6 +606,12 @@ static void platform_device_release(struct device *dev)
 	kfree(pa);
 }
 
+static void platform_device_release_full(struct device *dev)
+{
+	device_remove_software_node(dev);
+	platform_device_release(dev);
+}
+
 /**
  * platform_device_alloc - create a platform device
  * @name: base name of the device we're adding
@@ -848,7 +854,13 @@ struct platform_device *platform_device_register_full(const struct platform_devi
 	int ret;
 	struct platform_device *pdev;
 
-	if (pdevinfo->swnode && pdevinfo->properties)
+	/*
+	 * Only one software node per device is allowed. Make sure we don't
+	 * accept or create two.
+	 */
+	if ((pdevinfo->swnode && pdevinfo->properties) ||
+	    (pdevinfo->swnode && is_software_node(pdevinfo->fwnode)) ||
+	    (pdevinfo->properties && is_software_node(pdevinfo->fwnode)))
 		return ERR_PTR(-EINVAL);
 
 	pdev = platform_device_alloc(pdevinfo->name, pdevinfo->id);
@@ -878,6 +890,8 @@ struct platform_device *platform_device_register_full(const struct platform_devi
 		ret = device_add_software_node(&pdev->dev, pdevinfo->swnode);
 		if (ret)
 			goto err;
+
+		pdev->dev.release = platform_device_release_full;
 	} else if (pdevinfo->properties) {
 		ret = device_create_managed_software_node(&pdev->dev,
 							  pdevinfo->properties, NULL);

-- 
2.47.3

