Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21DA0C44514
	for <dri-devel@archiver.kernel.org>; Thu, 16 Jul 2026 12:32:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B79F210F2D7;
	Thu, 16 Jul 2026 12:32:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="eXuj5Xjz";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UaU77ebZ";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6398010E357
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Jul 2026 12:32:02 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66GBiZaE3747263
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Jul 2026 12:32:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 T/W6God4Jx8WMmxqemjau5eSXR0NRTo0Cd6tDZl/0fQ=; b=eXuj5XjzzunNm/PP
 yT0Me3iks0+irV4A1RWwsgN/fYytSkrNebwbB3QEFO3664d7gCm6E1ZZXeeFDeCv
 6E4t5fQQOsPOfor26lfKXGo3KwdykavAK48uKvV9hEdsmqakxjsWMrt+kYlktFJ8
 P1PkLv77JgWgLalKxdfAmOORicqGsc1EgOCZmK7odqU5NhSkJso0QHrL++bifx21
 ifeVN4pLi35teK6jKFz3ZiA7Us624AVPJAG4569iETxdg8CcgdvKc7CEds3LhZOF
 AVJXVkfdZOP2NIyelNHFosMddhcOVXHcdZkEa8h2vJ66FcdwD/hnjGcSRiHInLv+
 cW/1lQ==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4feq3pj4rg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Jul 2026 12:32:01 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-51c110a3b6aso46756241cf.1
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Jul 2026 05:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784205120; x=1784809920;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=T/W6God4Jx8WMmxqemjau5eSXR0NRTo0Cd6tDZl/0fQ=;
 b=UaU77ebZavCi4T2QYJAl6v+wychMuIq3qo0QyERR8xQeQ9Soz/WcW16VNXnajPrAPZ
 RMOa/ZX4tXxPvhTtRooIi8B4Bz7nqRxM/me7vQf88EQwWy1r9+li6g5fbYk3nk66fmf7
 EAuaX3OTfMfz+Nk2/FHgU1QhV/7XPAS8rXWGa0awbCNGYRQ19mDFd4mg55fsCF93o4rj
 vcZDquQwq3WY7kiktfNDe3c1zqLfYT8VGmuy86NtJa+FcvhRSq0qK+g0XaaxkkFtXsK0
 ez+Ubip5W6QbYchBNzc3zgd0I6dzJOnHNqkik5bMHqUm/PN3WF3rxQ5ESTmG8OjalLb0
 C+aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784205120; x=1784809920;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=T/W6God4Jx8WMmxqemjau5eSXR0NRTo0Cd6tDZl/0fQ=;
 b=IbF4bUPSLThXJhDxAYt2XYzF5piV+mVhC9AKkFxrP3JfFlbqlx2jmSbd3NBHAIhB02
 oiEL+bjkbZQCPzGvsmvyHJXtgQLuoZ9roYDd5TLLg3UIn8xZ9Qq1RqF7jDDy3Z40gp8d
 cP/W+0bHJ3AaQFLBUA+VHBBHFbd7pMB68Gdkf4+A/zH8I2vPnHY9J03RBOeI0fJQFvd0
 AVcvuqD8AzTM1yJleWjteGqTWzFET7vv9Ulih0vxdtNDRqOlWBGa3bBvGlAd2F1hlezy
 QPtuKMFYmFk1xOC/EsTJFYoA1vtHtNi/bd7fUJmsg2JuFJtJ2SugXuEymAEbEF87jy+E
 bFLg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rpc9AaXBIEQsaSk3Jo1MogXxINsQyEitHZbRge2QZOu77zBlY9jxpPjewXeAsySSuUlC5dY3kaXr+M=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxTHJp3kM2Z15VkHL2dOn0+4Ak7cNFbP19XVBR+sIpS2aZt/5sm
 XMnMWAvQzMqoEtHdwTLkEBIXa+tadsfMcH/+tjwZ7LDTW5uKX9/EcbIzV7VZXnjoj8KmeDh8D4W
 R4AeXH1jqoLU50c55qncClDXwQImZQzPZOSvYmcuaW3lq7AHyEppvj+2T6G/hfT6IDgJxZOY=
X-Gm-Gg: AfdE7cn9tmIv97NJNvK8Yj0fNWNq+crOHeY2sNQzIPn+UkFAc22hsbJIxAozu1iwWy2
 fY1d8nWJiLiZvDc2DXIJzXQI/J2xfadtPEqd6SrvvmsuJh1PHnwNiqHlRJIGlkaAXKQO88KvqO4
 3+v1vauEGz+x0/sEhmplPwhoOnAGSS+USw+s44RYUhuRA2iIVyWiOYuDewqgxt+IVGmt4kLXS/w
 kEb5Z0U43hhm70WcnXZnJywUNUVC871IXxu3UpyRxv3fBt84QkVcmCdEJcGvcNezVxt0XILlnPF
 5+QJd+pYSDHhKQ64cfMTzSpPlS0swjtQa0JcJwB60q4rq2nTEwk9zqctXlMENouz0g06AU2nNBI
 U9tr5iL5hVHCxQspCRJUCtUIcCWU=
X-Received: by 2002:ac8:5747:0:b0:517:5e3e:526f with SMTP id
 d75a77b69052e-51cbf27a872mr223608271cf.52.1784205120336; 
 Thu, 16 Jul 2026 05:32:00 -0700 (PDT)
X-Received: by 2002:ac8:5747:0:b0:517:5e3e:526f with SMTP id
 d75a77b69052e-51cbf27a872mr223607781cf.52.1784205119845; 
 Thu, 16 Jul 2026 05:31:59 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:76f:d108:485:5b34])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f464c7c96sm23766635f8f.33.2026.07.16.05.31.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jul 2026 05:31:59 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Thu, 16 Jul 2026 14:31:36 +0200
Subject: [PATCH v8 1/5] driver core: platform: amend the API contract for
 fwnode setters
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260716-swnode-remove-on-dev-unreg-v8-1-5c2b8cc38c28@oss.qualcomm.com>
References: <20260716-swnode-remove-on-dev-unreg-v8-0-5c2b8cc38c28@oss.qualcomm.com>
In-Reply-To: <20260716-swnode-remove-on-dev-unreg-v8-0-5c2b8cc38c28@oss.qualcomm.com>
To: Maximilian Luz <luzmaximilian@gmail.com>, Hans de Goede <hansg@kernel.org>,
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Matthew Brost <matthew.brost@intel.com>,
 =?utf-8?q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>
Cc: brgl@kernel.org, platform-driver-x86@vger.kernel.org,
 linux-kernel@vger.kernel.org, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, driver-core@lists.linux.dev,
 Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3252;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=8hpM+TrGfI2rbJN2akFn0gkqMVl45ni0Bp0sA4vGJ68=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBqWM828c87nWIkYkRuS35nkpsw+eafF3SQ/NOI5
 nZphlbwEjyJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCaljPNgAKCRAFnS7L/zaE
 w1PYD/0ap/sMPuzCQnZ66mfD+nEmu5nhkrMsO+nv/OYqI/SxhOEAqeCdbYwNEDMFBtr3nmItPBo
 izcMwlPWbzo3M8RG25l8zyCyI4A1dX3gx87PlsQauyNvGK5+EhyDzOVmKl2l0miKpRPVg6d5ePQ
 n6x+1eThx4PH98F66txfVbot1AKaqdqN8gfpI8QF/tJd5nvxExDKUc+jhcvgsc3gIfVKtf2l+Ml
 e5qIbc1muPS4/+Ysn8rVZMhCKLMVyLQ4Q9CO+HrHCibK9guPfwNhUvfWzKEXOmOXSiTBH02PXOY
 rZyiFMCDEPKnTyGDsZ5AwcaALmSJ5FauJf4Sr5/0MAM96iaPTpDVMFotgm67DrIQw7QIaBXAYJK
 wjzJXlMa24vR2eIFaPD24p1vSJ+I7epc4XBuIt2rdTEWeA0EnjrWPtOt5146iRgmlWoko1t8AUl
 v0FRoBfcfzmSf6xyNXi6652asT0Rbz+zfkIoveYItuvk1OG1mHE4I0WNIh0c84v/pmFIEg3QO/N
 8CfVARbevx8CJnGoYN5SZkVPeHFRqrM6df/KRb3czazS02Fq2qMpHX277XkDU8BE6xBrOwLyiuH
 EwazYUjxAFzjcjYelFGMIggKKVRYZ4U62LX4kx3M5rno+x07Y2WwUUEbkVLd7XrO+TNeu5AU1nO
 vcwxjx4pFdq+45w==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-ORIG-GUID: HzNlyqasiXk4Ff4CmZM-ghKSZYGkWMfi
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDEyOSBTYWx0ZWRfX5e3Ex+I9Zcme
 dC/ocns4fVuwqIc+Jb9Jfa6/dnaorMR/FhC5hn7cVzMKFfCB0H7jgoU9ia9kmyp5Rg0A7hHIK3n
 TMLpyouu/ItuHUd+m2AaX5x+8mEvqz0=
X-Proofpoint-GUID: HzNlyqasiXk4Ff4CmZM-ghKSZYGkWMfi
X-Authority-Analysis: v=2.4 cv=PN8/P/qC c=1 sm=1 tr=0 ts=6a58cf41 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=UJBV_kE8d4TeT66hubMA:9 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDEyOSBTYWx0ZWRfX5akZ2hbezsDR
 b2b2nCt4Y8A8NF8EN14KORHshyuh3X7t9kA0yWVwHJQm1Q3E/Ze370WzWG5oa0/y1FVGRYf6inI
 M3kKGQlTOHETFki4Yntbagb92MHu9nhE8Gpk17GzuCVgr8+VV0sIVf1472WnYmur//nu0y/lwyR
 NGUFU2T8UffX1SCrFwYPMD+eU6z+bDzsp7i325OtOChGsH2+lE1wVJJiOep7J5jdOsqamf5KxRS
 pODQRoPEJ5XahT62N1N3dP62/5I/XpBJ7gi7IpfuKuwTVK3o1ky++9U5u8Yq/EWp4uaF7049Swo
 rX63RtooQRorofnpGpdn+NrJaGbCvVaY4eKOD8jxAtu73K32cZ62lDB8j9uBSsNiVJbDPjj+tO1
 N/dZ8+TA53hoy24m1kgcmvakgox5OTiWwLZu8WlUp+6YS5sTiqppvviXPiy4SlZ6J8w4tI4gSpl
 uLDJLPI0qNsjfcZpgMQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_04,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 lowpriorityscore=0 phishscore=0 adultscore=0
 priorityscore=1501 impostorscore=0 clxscore=1015 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607160129
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

Calling platform_device_set_fwnode() (and by extension:
platform_device_set_of_node()) of platform_device_set_of_node_from_dev()
for a dynamically allocated platform device whose primary firmware node
is already assigned and is a software node leads to a resource leak as we
never perform the corresponding call to software_node_notify_remove(). As
there are currently no users for this special case - just disallow it and
warn loudly if it ever happens.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/base/platform.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index a71015f1d915340aa01ebfae67196d4d7ccecba8..fb57d487a6c2aba799b4ca5ccd089006cf2d8bf6 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -707,7 +707,9 @@ EXPORT_SYMBOL_GPL(platform_device_add_data);
  *
  * Assign an OF node to this platform device. Internally keep track of the
  * reference count. Devices created with platform_device_alloc() must use this
- * function instead of assigning the node manually.
+ * function instead of assigning the node manually. This function must not be
+ * called for a platform device that already has a software node as its primary
+ * firmware node assigned.
  */
 void platform_device_set_of_node(struct platform_device *pdev,
 				 struct device_node *np)
@@ -723,11 +725,20 @@ EXPORT_SYMBOL_GPL(platform_device_set_of_node);
  *
  * Assign a firmware node to this platform device. Internally keep track of the
  * reference count. Devices created with platform_device_alloc() must use this
- * function instead of assigning the node manually.
+ * function instead of assigning the node manually. This function must not be
+ * called for a platform device that already has a software node as its primary
+ * firmware node assigned.
  */
 void platform_device_set_fwnode(struct platform_device *pdev,
 				struct fwnode_handle *fwnode)
 {
+	/*
+	 * If we call this function for a platform device whose primary
+	 * firmware node is a software node, we'll never end up calling the
+	 * symmetric software_node_notify_remove(). There are no users for this
+	 * right now in the tree so just disallow it.
+	 */
+	WARN_ON(is_software_node(dev_fwnode(&pdev->dev)));
 	fwnode_handle_put(pdev->dev.fwnode);
 	device_set_node(&pdev->dev, fwnode_handle_get(fwnode));
 }
@@ -739,11 +750,15 @@ EXPORT_SYMBOL_GPL(platform_device_set_fwnode);
  * @dev2: device whose OF node to reuse
  *
  * Reuses the OF node of another device in this platform device while
- * internally keeping track of reference counting.
+ * internally keeping track of reference counting. This function must not be
+ * called for a platform device that already has a software node as its primary
+ * firmware node assigned.
  */
 void platform_device_set_of_node_from_dev(struct platform_device *pdev,
 					  const struct device *dev2)
 {
+	/* See platform_device_set_fwnode(). */
+	WARN_ON(is_software_node(dev_fwnode(&pdev->dev)));
 	device_set_of_node_from_dev(&pdev->dev, dev2);
 	pdev->dev.fwnode = of_fwnode_handle(pdev->dev.of_node);
 }

-- 
2.47.3

