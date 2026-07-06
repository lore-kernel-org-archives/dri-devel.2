Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CB14C43458
	for <dri-devel@archiver.kernel.org>; Mon,  6 Jul 2026 12:45:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BDDDF10E964;
	Mon,  6 Jul 2026 12:45:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="WzwPlfeX";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="QQvjIpO+";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AF0D110E95F
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Jul 2026 12:45:37 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 666AxOCF395441
 for <dri-devel@lists.freedesktop.org>; Mon, 6 Jul 2026 12:45:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 zax1X4XbzWPUvVXMfqloW++pJk2JO1xOHc7DAhzePfo=; b=WzwPlfeX2hhdhkII
 9mnkZNBd8gqlVcTDS+eavPmnbC7oMoyBni7znpijGAwUU2FZu9zSDwwLl1iAYZ0K
 joB+HxaCm+VAbrupM2n2A/V5ikNIeDfyidY4PqG+PZFZ/FOU3Hi45HGVYbBYL/d/
 y8TbNGeskzt/7YM9d517vcR3/L0dhwC/CKql1pMbkioLHRcLDrpOUb24jUmBTzae
 cm0dQ8l2vMPwZ38md/dVJErOhBAPAyq1GQDdUmXsHYvppqFuSWBLop/RmoitVyCW
 fbEl1tKap1vDrMh6A71dJd/+N4ZEq3d4RSqsPDBlUHc5UfeCROUdWNOdgxxJiuSx
 Ug9/YA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f89qpgqs1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 06 Jul 2026 12:45:36 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-92e9a2b95b5so463832685a.2
 for <dri-devel@lists.freedesktop.org>; Mon, 06 Jul 2026 05:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783341936; x=1783946736;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=zax1X4XbzWPUvVXMfqloW++pJk2JO1xOHc7DAhzePfo=;
 b=QQvjIpO+qF6+knLsAkzcWhIj8M54wDeQTdo61qt/sBhQZSVySIv3PuaXWHOu7w02qw
 gZ2y2Nw91fzPSVI7Iciodbh6ATytKn5QnQlqT0fjk7Bqc0c5ymoHeCo++wQqHgzsl1Dy
 XV2d0sUsofaWda0koJoXATdO6cMARKOIXFL2nFglO6uwa4in3A7chpmfq+rvkdmIPQoe
 MErfNwxM151B9iCLfKCDKMLWCLE3LwGPXl34paEr3FL5kgSzcX8j/P9+Rgt1Sexo9VNJ
 qKhxw0mUE1xpsM6HpqziMUTrVDMZYXj146J9jh9qFFIxb/gKJopZh6XwzfaWGPKJA+o6
 4dvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783341936; x=1783946736;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=zax1X4XbzWPUvVXMfqloW++pJk2JO1xOHc7DAhzePfo=;
 b=PhPXRgB5MP48lpxaWgU2RdGTOAEQevIKok51u0ZTZiJaLzbmV4s7tfTnthJggbsaSW
 xL9AKe5k4kR5e38USqXZhc1DfqBhpXBKoEPLhduvpQcaO/ON/lRG5N+Q97MH/1EA3qo7
 QtPNb9RtUp1I7e++1uxt2ps8FbSK15v5XnuHPZxfKEO8YXWHzEFHCOXlZ4DMoK5PEtL5
 CS8kHMTLwH1VFPm+bMRYX/4PU7ofPZe3Z8D9aoQd/KQlw+huwr/W3cborAyLwqGmSNaP
 AMaMQp1PTq0k/mWHOn2RhE0qg2FBjhN5ip8dPS9pUb0lwuxd+HVqKZHUsnndr4cFRQew
 d/cg==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro/7MlWvihQR3LsMRlyA/pEk6PwIWVLduxZmQyjABMFRSUO3dUWB29CNVN+NvtDLl0tFeuYtQ7ma20=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyLZlZ8ojAsD5yMde1FTJwalHFdBuS1fm+bu5vHc2i8XvkRejE4
 6o4rM/8vHA2yD3YlJVYxcEn0NQSHtx99cEmwhZa0QxnXgN8S8tzFbh0Rt85ZWCSRQeHaeDV8Oj0
 xBs6/ug90pxd840HWA6hEIkohNUwx9/z61E9e0QgcvIOhFJwpX5FUz8tlBaXy3OmqW9HfWrE=
X-Gm-Gg: AfdE7cn/hDeN/2uZdmG6JcXPIFbiMSbpPHE/jXvQ/upZS5aXZV7v/3UPDYuNhU5k1Qv
 Y5Cb7fBuW0SxQXWsZOPDbvJfgtcdj8TPuZtbKiSKKVrQBOsjVxEeE4SeehVmnyD9CJ2JzngBEqk
 jBcSmq/g30INUIpxbfIY0qeJ3WazGeEGCZHfmeGzOrCeUbnTybB7sz3UQGj2JySCOWbhR7oUBCr
 pzMw7TbZSnnoeAGXOMMjDte1uCvGIT6ZQzEGfWtUlTNghl6DuR02ToZQbAdueIbr5Uj4hIRSD9x
 gO9SrRRRY8F9/rDF71Ix3nkVMdCscz8S85ijmh8EPjJL4wLm95F2yO2Hh6FLUk2V18q/XR6cnFs
 Txye7b7Ys+wuduDVUr5XNMZgTbWmlxScQCSVO9wNU
X-Received: by 2002:a05:620a:6888:b0:92e:76a1:96e2 with SMTP id
 af79cd13be357-92ebb5dd29fmr49715885a.43.1783341936174; 
 Mon, 06 Jul 2026 05:45:36 -0700 (PDT)
X-Received: by 2002:a05:620a:6888:b0:92e:76a1:96e2 with SMTP id
 af79cd13be357-92ebb5dd29fmr49704185a.43.1783341935528; 
 Mon, 06 Jul 2026 05:45:35 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:86f0:c42b:ef4c:d3bb])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47aa0a55be4sm22126539f8f.31.2026.07.06.05.45.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jul 2026 05:45:34 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Mon, 06 Jul 2026 14:44:27 +0200
Subject: [PATCH v3 15/20] drm/xe/i2c: use platform_device_set_fwnode()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260706-pdev-fwnode-ref-v3-15-1ff028e33779@oss.qualcomm.com>
References: <20260706-pdev-fwnode-ref-v3-0-1ff028e33779@oss.qualcomm.com>
In-Reply-To: <20260706-pdev-fwnode-ref-v3-0-1ff028e33779@oss.qualcomm.com>
To: Lee Jones <lee@kernel.org>,
 Mark Brown <broonie@opensource.wolfsonmicro.com>,
 Thierry Reding <thierry.reding@avionic-design.de>,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Srinivas Kandagatla <srini@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Vinod Koul <vkoul@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Danilo Krummrich <dakr@kernel.org>, Rob Herring <robh@kernel.org>,
 Saravana Kannan <saravanak@kernel.org>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
 Andi Shyti <andi.shyti@kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Doug Berger <opendmb@gmail.com>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Ulf Hansson <ulfh@kernel.org>, Frank Li <Frank.Li@nxp.com>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>,
 Matthew Brost <matthew.brost@intel.com>,
 =?utf-8?q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Peter Chen <peter.chen@kernel.org>,
 Paul Cercueil <paul@crapouillou.net>, Bin Liu <b-liu@ti.com>,
 Philipp Zabel <p.zabel@pengutronix.de>,
 Maximilian Luz <luzmaximilian@gmail.com>, Hans de Goede <hansg@kernel.org>,
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Krzysztof Kozlowski <krzk@kernel.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: brgl@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-sound@vger.kernel.org,
 driver-core@lists.linux.dev, devicetree@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-i2c@vger.kernel.org,
 iommu@lists.linux.dev, linux-pm@vger.kernel.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-usb@vger.kernel.org,
 linux-mips@vger.kernel.org, platform-driver-x86@vger.kernel.org,
 mfd@lists.linux.dev,
 Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=929;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=uLXyFApgr30TTHInPgHtMrjb0JTo4ifQAXB9pVDm0JI=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBqS6M6Q7+TAJQm5eCNk8IdPrpLpvdQnPdPUQTjL
 v3En+SR8n6JAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCakujOgAKCRAFnS7L/zaE
 w8sVD/9FSqpOFwI9xNUjUgfMc/OBmnlJ/oPR6pweDlgzV6UYHA7LfN0Pjqwd4sMEmMh6Wsnob5d
 k5RtgQ5z9XWNhsvHI3l87qGhsD19PPPZHOFoiCxPJH260MhNlWPZYBx2yweOyn0bN/V4wFf9g8E
 WRkPyr25sOK7K/X1ANFFS59a7tIa8LC9kv9YjPcHIjH1uFYiVkWjnW9ppECk8kTdvO8SWTFM7nI
 8WP23VpiT5mCUgLu55gknhLZB/psW83c9DQEEkuIrb0z/cGLCuYvEzVUn0XKpc6p7P3YAtGeRnl
 2rKPZu0LokRJGIl8gLTIMk0QIaIpPpX6qBRIVqQ200ie5Fkt1vDv1j03XvgAsNfgd5JmcOmDq39
 ANn6wdh+tlp175G5+WK1dITngNhOENduAlOc76s0TszKG/mEZ6hhU/iuqddrZCHMf4UezBFdFuo
 DHZaI8xhaz9Xh24q/ti1OQO4612k/L3WtW0Wy4N5V4C3miPGqdxvznUUccBigJrbmEXGqBe/vWN
 5ia+ZsPJ3kddXqmkVou5nmLPatbfYJc7IG17dl7Yz2gVIX9MFpeeqbGt/5nMDtteEtbn7bgghy3
 ZJq2uY2OlHmwjmbGZVO9n7FNg59XF8tF1/kAFLXE2UeZXrgpGxERgwyXmv61/0L5I3v5f0M9vc3
 R1N9ZRzP+87JgLg==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Authority-Analysis: v=2.4 cv=c6qbhx9l c=1 sm=1 tr=0 ts=6a4ba370 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=QyXUC8HyAAAA:8
 a=EUspDBNiAAAA:8 a=Jb7EFCjKRuSTjX4XlnwA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-ORIG-GUID: TJyOVh9b4-2iUw0tjBlxm0_An3xfVRZh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDEyOSBTYWx0ZWRfX11LyJa7WmbXn
 Z5t7myXeG1ZjFP3Fxu8izbtWzaV82IdrZCofmkl34I09hj9MH2OTxPD4qen1EjkfplMtcCpDpOn
 YJ5i/SqCkhlY555PAbcT+B9sQN6745y/g+qxO3piJXt0+sYtMQQ8VRoB5Ns325oFfOaluJqXzmz
 DdJQ1Y2lt9Q8Yf1DnxKHP67T/1FlxdpVRS6b94fZf1hJqZo/IZUqixLMk/fCAnQut5aW57xyuPt
 7zg4NflYP167l+XWzM0IOqS92nLiRgZEVxPaMHV/IXBiPQnhxvXdk9/GDQ824Sj3nGPfVtCsgWg
 k+eGYlktpq/qEh2qcwszWwKcoaW2ByRutLS5PsgrKG7RIDvJP56x3yWJp6aT39oG0rPZB5ipa2P
 fLgUyTdUW4NpEkTXUoKv9G/JoqTc0ys1iH5J3U/WPggtpjaYdGn9/xdWk5DOvepcX5FvfPS8C2/
 VwcoztpT+/6b5/pUERw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDEyOSBTYWx0ZWRfX/wreEl9K938p
 ipP1TZJz9J2VHX3ZisIQDOkUjNS5OgjRtXe/1vYrx4WRss+APJhqiTjKg2kNz7WZJiVCSgbOXPY
 Q1iVZDRfqIQMn9L1S+cOjnB/GHri7gY=
X-Proofpoint-GUID: TJyOVh9b4-2iUw0tjBlxm0_An3xfVRZh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_01,2026-07-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 impostorscore=0 phishscore=0 adultscore=0
 lowpriorityscore=0 priorityscore=1501 clxscore=1015 spamscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607060129
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

Ahead of reworking the reference counting logic for platform devices,
encapsulate the assignment of the firmware node for dynamically allocated
platform devices with the provided helper.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/gpu/drm/xe/xe_i2c.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/xe/xe_i2c.c b/drivers/gpu/drm/xe/xe_i2c.c
index 706783863d07d66b4685005d6649b3cd143ecc3b..af4ebd93ad8e68c95a14cdf99de0959fbe080354 100644
--- a/drivers/gpu/drm/xe/xe_i2c.c
+++ b/drivers/gpu/drm/xe/xe_i2c.c
@@ -123,7 +123,7 @@ static int xe_i2c_register_adapter(struct xe_i2c *i2c)
 	}
 
 	pdev->dev.parent = i2c->drm_dev;
-	pdev->dev.fwnode = fwnode;
+	platform_device_set_fwnode(pdev, fwnode);
 	i2c->adapter_node = fwnode;
 	i2c->pdev = pdev;
 

-- 
2.47.3

