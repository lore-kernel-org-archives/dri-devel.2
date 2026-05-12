Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40BC3CD4851
	for <dri-devel@archiver.kernel.org>; Tue, 12 May 2026 12:00:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 675E310E5A0;
	Tue, 12 May 2026 12:00:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="nmRF+qkO";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hC9EorXb";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9D14610EA5C
 for <dri-devel@lists.freedesktop.org>; Tue, 12 May 2026 11:59:57 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64CBce0F075044
 for <dri-devel@lists.freedesktop.org>; Tue, 12 May 2026 11:59:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 AsIlzmh9tphlDY1UgVWouFfmn5szfdJ33CZ+C2oPx7E=; b=nmRF+qkO4mGQ0+Nj
 XiOUNC4GoKCSEBmbKGynKNgdlODGWZYMxmqGXvqXoBsKRaeWPJTBnRg2XrDqeT0z
 Ep2XUuJIQ5+uli6AJEgiVUfzZqzJzapiWo9BCo5LW9efKZJglz7MMm9E1cDLqrne
 UH2pSb0c163G1U6RUcWsfb77vHwCZ8MFL/U2UUhoeIBwEg7RmNFRiKLN55ZIlcHk
 sjxroEZszldR6ogPUFJ7pgbs+rTamRBngCZN4kmYqAGufDsqIyh3mh8vuBKEeOjj
 qxVhLeTPT4RRu5ASdw81uaVfUslDLE/b5CM8gcElkYUoNjoLGoSAjuHoCKgeC5rZ
 u8jleA==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e43gyg52a-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 12 May 2026 11:59:56 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-50ea1a7a5d0so28729621cf.3
 for <dri-devel@lists.freedesktop.org>; Tue, 12 May 2026 04:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778587196; x=1779191996;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=AsIlzmh9tphlDY1UgVWouFfmn5szfdJ33CZ+C2oPx7E=;
 b=hC9EorXbWLpT2EDk2sqInmz+P37ORlwSo7eZglhA8VJ+Mv7SHShBi//XFzc3ffIw+W
 LLkO/3K0y5/jK8wYnePPmreda4fWumARgwqVdnaT7+8xbMki0QpPMk8TGnAKm4LtUFsk
 /af5XKKFzHDd/wz2ndnCwhIETqtpCgK7rBio5Lt78O1HiBBhSiXFRF/H0cPrYh2vVN3e
 Cqodn/kjKoyOCpDUF9wINwUyk4mvSCu/sTkAhRzTBCNcTczAL/UXuzO57aGoRbm8WLFQ
 ET4TLLUxvvEGNDmi5Dre2urExifpBomfT+7IzcKc33cYrOMvavjZgmn/3U08jyxkgUxj
 G7PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778587196; x=1779191996;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=AsIlzmh9tphlDY1UgVWouFfmn5szfdJ33CZ+C2oPx7E=;
 b=We0W3CNo3M0QY0G6n6OYgYcI9rutlhdjB3XtIX4tNaSifvq4daTtjaZ8ZSpfay4ugG
 U6XhJZjCukcGueJDtnU8ztL/trH6vW55xLWIKMsOazvwTR6ppEAJ2FosuBTfr9hvSe8L
 YV+r9CEyxOB97zgeFLoi9wu1yoRwV0+1f/57BSVkJDfILm+i3k6DYZNCQzhEuxQYRQQn
 kTpeleMUIa/UdobYLX5wV464Gjzo53yVwixAC9Gzl4erJ1bGd1q3V1ULn+uANOiYLFax
 TSyiuKJNlsGrnS0SOSv3BF0EsCu0WPPB9jdXhP4aMJtzQAfqg5ObRMBDNw+cPH2ktiM7
 DKxg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+hsG4pQu2U9Ue4FHz11ekbfSDsNBTqfRVRlM/SQ1N14b381HuWvOEjNP8t+pyYxb9R/aWl7H2z+xg=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxASsJ8sR2cdHwOSPTq/bSBy9RfYUTKOQPF1angVJJj+rAe72EM
 +iSFwJrwNggCzC8907QHrTk6PuYgU5OFdLe2nENDDgl2TaE2S+VYpLcdx6DGzgagbfeKSQp457M
 tc29h1d7VLZjOs5X2lKC4W87ugL0Kcg48JXwsugWroWadEi14oWci97aNxQmg0Wx898P+lfo=
X-Gm-Gg: Acq92OGVRZy/OwEZy2RAdPnWaf86x/gN7aPy8AjTErNxJyn2pPt19VXzgUwI7RqbOgl
 6tyEj6jLEGNG9de2Gl2xCQKC6EncVCxITLYOb/9wt3O6K7wfxujVecM3PxaQXtS1a4G4IM7aKv6
 qKu5JZPvCXQP8U9fdetPXxUOkI3Du9HIx3zwayN4wqVMV46cVU2R2ab7Jt4CQntCftxEE6aGR/d
 Lj6Tmr4E5X3r8xnfZ//PEVdHnZk6/Y+GUakCl9ovHEQKVKYbbtaPkq7I3nB9lH4HCUjj0VVccyU
 YiO94jq4z/DeCDBiNVnxOcx9DwGAmooOZdvyesY4UfGqObqx7YdT7/tEFe68umHfGK0BSKHpNAh
 Q1QI1zVSp8/beAbiX6J8zUGXuXCF8hrUrsGicNN8wYDlHyWkc63c=
X-Received: by 2002:ac8:5fc5:0:b0:50d:819f:e7bd with SMTP id
 d75a77b69052e-5148e7caa96mr244595791cf.4.1778587196106; 
 Tue, 12 May 2026 04:59:56 -0700 (PDT)
X-Received: by 2002:ac8:5fc5:0:b0:50d:819f:e7bd with SMTP id
 d75a77b69052e-5148e7caa96mr244595371cf.4.1778587195623; 
 Tue, 12 May 2026 04:59:55 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:74a7:1c82:3f14:b431])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e9067811dsm73933355e9.9.2026.05.12.04.59.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 May 2026 04:59:54 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Tue, 12 May 2026 13:59:24 +0200
Subject: [PATCH v5 2/7] driver core: platform: make the swnode check stricter
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260512-swnode-remove-on-dev-unreg-v5-2-0035eff63812@oss.qualcomm.com>
References: <20260512-swnode-remove-on-dev-unreg-v5-0-0035eff63812@oss.qualcomm.com>
In-Reply-To: <20260512-swnode-remove-on-dev-unreg-v5-0-0035eff63812@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1181;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=FnVwIXx6Ku4B5jDoy/RTsmZKiOzQrXf6yp9wvc3bzuw=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBqAxYuSqeVpF+6Oi3kvW3NNEoHQCk6tpKW1Pyi7
 2WNxlR1TDOJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCagMWLgAKCRAFnS7L/zaE
 w9OvD/9TDVT4yBV+W9E73T/WZHkxETcn/5Zk5PW7qxDBDuCaLa4ncmLsd4i8n3W9vPP3YJlGFyD
 XewbZFaa3M/WHPF1KHDoYn6jJpB3qM42PWskLqakoaze3tZ4pcAVreLZyExLmbgrmNXB2mdAU3w
 f6oKrs5sh8GkgNtnPG+ck4C98lSqXvjFfllUJzMbrzlO6qCEG75mxRevG+DgCP5HLCxhx/R+lVl
 7QS0S4RKlNGZlPER3Vv6r+yl3EcpztihZtDO9qUeOvOahADyWw4YKVYH++iGn4jawAuqTRvJ/nM
 a8L+U/mv+V7fxOyab0Dmyp4UnOOM/TYiqiIlF5LaysyZRzV+qVwPchvoewhU8JiqQ0Vm2/qn7oQ
 x5MZkj79CENg7XMcb78yVc1cTsAtk2Yb1BG8fFejh7Xq1ODw7mTOSp9aX9aoIft76v40+g4ioSy
 zwlzhz8C0spx54GhTfCtCDCD6GWV35k8fm9iHd5FYuOlO0TXf3sEZVpW9X9b9DOzwnJHtZxWYEf
 rHMmbTrSz3LLLt0td8k9VygyecaznwyolREajGcE8uElhU90E7lJPlDoOxAL+cogg7ulDA5tAB9
 oycQ+wKAEJ6jX23cG+XhjCdqJ/BF0ayheRl1mivwmjiEkik83S3A810JinvBU50vzJV6THDwRwG
 bf1h9uELBVNrWuw==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Authority-Analysis: v=2.4 cv=fMAJG5ae c=1 sm=1 tr=0 ts=6a03163c cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=mI8QAYneSzpRMWOT9SIA:9 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-ORIG-GUID: R5dMY0QY-R5hQtea0Hd9ukGehBy6Ou4b
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEyMDEyNCBTYWx0ZWRfX9ab8lvA1jJnl
 7Kn+/AdmlkgVHIWen2aptulUr2+hvuzbZm9yLHBaB+2S7UW/RApir56sUr2ozlsPgVW/R8jK3YE
 C6wzfoWrUNPOT8ReFsA/dC6b52H1geDbvt+DgwRxd6ovWIFMp5g7SgtrODCpYj6U2JsEWPFZsSw
 NxmMWoqUcP/xghgVRrhQtj4gUojjtQXzy8ghtbIH934iVKZlnHzqQh7VAZ0sxtv/uQa+xWd9Bay
 0TSxtc2n3N3GWyKICxJDWGtTVh08yunDWN88f7BwVgcCj5Hi/JOWC9x42TCqixGFeE5Ix9AjYKi
 3eCD5itWt30oURpWICB12uBoZ//McV6nEISkfb9MF5gy6MsOlQD81B5kZ2uwfghw/InPscHWzzI
 4xAvbwKq2pz9oqbT2ucnyp5OnwbLMCO6vqzxX/4zH/sQ/T68gih3LAWGbWD/74RV0RkCxbZddGo
 GG06mnzI0zMmIoGyNRg==
X-Proofpoint-GUID: R5dMY0QY-R5hQtea0Hd9ukGehBy6Ou4b
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 suspectscore=0 malwarescore=0
 clxscore=1015 spamscore=0 adultscore=0 lowpriorityscore=0 phishscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2605050000
 definitions=main-2605120124
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

Check all three possible situations in which two software nodes for a
single platform device can be created/assigned in
platform_device_register_full() and bail-out early.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/base/platform.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index 75b4698d0e582e67adafa78c312d75c72fd654cf..18f33bec36726490255bc7ca3c4ab07d9b7606b0 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -848,7 +848,13 @@ struct platform_device *platform_device_register_full(const struct platform_devi
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

-- 
2.47.3

