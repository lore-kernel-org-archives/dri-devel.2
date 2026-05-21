Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22D99CD5BB0
	for <dri-devel@archiver.kernel.org>; Thu, 21 May 2026 08:37:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1CC2F10F26E;
	Thu, 21 May 2026 08:37:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="oHrTiXeE";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="aa8jnO0c";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 055DA10F26A
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 08:37:12 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64L6mIQ21798612
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 08:37:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ukktCil6qFV5J1LkkLCVMIGTbGIgPkyHII6gX5uRxIU=; b=oHrTiXeEYw0WRHRT
 0JryuBJBVPGqSxjyOTxM5WpWR6iIX+t5Ehvvw7Ijy/GBhhIDg6CRp4j3QlEKLHrd
 +T96al+7FsYIjjP2jU6FOexSof2OZMQ8rNPgA0pbm1sVXGeUZU2LmQlLaiX36fx3
 MG+nBBELBSvdKBlncwtRnvz10SEQ3fEi44Jsy2GFv/ny2/9kv77+p55hQ3FGnrzQ
 IKaYfJHP4+j/gv2GVgK5+Euq6Esk471OF7JFruDCfx2cLtA7CQELRBGCRGfJBFlZ
 KngEWPif/BD7w3A+cd5xrKALQ79BP1Zurh4FsssoVkSxxz+bgCaXm7XUBHfW97zx
 +2sblA==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e9dxu41u5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 08:37:11 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-5104b861649so230841121cf.1
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 01:37:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779352630; x=1779957430;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ukktCil6qFV5J1LkkLCVMIGTbGIgPkyHII6gX5uRxIU=;
 b=aa8jnO0cG2yjZjtC7oeyuSDebh/b+BNrqRptREKOX6r/UN8iuD4bdhyEJNXi/9r6WI
 TnJkcWZ9QMgPhuzCQu/f06eTXDHok7VdUsBSGLUqL2Meb8mt6qV0jJAa5EPxotl3D8aE
 N8gnfYnb5poCSEgfwMeV5wq+GFy/nxSauCLNOf9fM9wf5ixc0zfs/c/E4FDe8txpXgJ3
 vrGyvwIuL34TMLSj9JuIJl+RjUa4WiWd1L+OgGGUZDrHbSJ1cVunjBwJSM/JN+10ZSc1
 XjWB2fTaJrif8MsMtuuMyjvAIOR56qXeBJHupg6RArxIRN2zcTctD0ZiUuxUC0nyudiv
 G/DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779352630; x=1779957430;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ukktCil6qFV5J1LkkLCVMIGTbGIgPkyHII6gX5uRxIU=;
 b=ezRJSwOkUrz1smWvpe05axojR+Ix4bOkeXPEjGeKa5LQJIjTHUODmGX1xydIULpqJ9
 PvnU7RhJY2jRFoeEIb55+mnrEEB6VF0qwqKa6zZuFlegdoUMCGMKICaR/XsAFOy1g7JW
 neoMo0MnQ1AnaZs6jP5nLrUTO0e4q9k1dyH1nNKS9qUJ+KOAlz0mhAUpnH/77IFWGIok
 W/EGBPEW35gK77Sc+gf0LdCMtDlqJpv7PUcbRXjR1c5cXVmKf0MIUVsBlZC6J7Bg0jx4
 7z3I23rh+JwMg4SX/sKmk4Uv9DxJgUR+EWHdUtSq/3uZQ2lIj5CEhuCQ5XpgdPUn4Q41
 zTKQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9vYBn9k0totUEDSPqoISvovDOLzBS8X7ERHGWND+y18K00KoDxiNHAc3+ncRlv+FKDQy1Hfl6iqtI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxIHv7ExgqeVP5mmkfkVyRB6APEBzT1hIlyj1rH2QCdipBa+u22
 vkxutN79kCTJa0OomGSYGG4lPiRkh9gFwwLXM8KhLJSURFM6+bjJFSimer48xQUksSB/YdYm9uK
 9TQNR2gmYRrRnBBb9tx8ln6KlPc1MXtXCi10IBSki3cggBp+rsX9+1VFJ/fX7AdEt6yqxzes=
X-Gm-Gg: Acq92OE9maKqKonkoCZcQqQwOw1LT+yVYz5HGPMcfue1AnfOzYL5IHZfoZyMGC0GrTF
 HYTa52JaNAdHZR+sv+O68VuyrsPpS5mOAAatPXZfm9ODQZL496AXJIwDvu6+yn+XkxkY3kOEgub
 2dRHzG1ZuEoypAQC0PElCvvdx46mm2UeSXmxhysZLRjqhk7HxwItwtxYFVMCIxPtpY2vS2lSB3j
 Ukw6nG7Keq8/y0eiCz7MJm9JL0LA2TcrAxZ2Hrq6u1657eiRHuMz+w3Mx0JvGa2iGEYl0aHHgNH
 ndDW5/65Qj0rptGaRpoGOHMT8R5Z2dxiWWfBz5iHdd8bqUxmNzmYxgLvmjRt46CRZDm67SAfeaB
 sCmY/jnaMBSzTmASZ/fqovENzWXIIy+tXYq8A2vMb+3dMzpCEUug=
X-Received: by 2002:ac8:5f47:0:b0:50f:bcfe:e8e0 with SMTP id
 d75a77b69052e-516c5477e17mr25148611cf.13.1779352630461; 
 Thu, 21 May 2026 01:37:10 -0700 (PDT)
X-Received: by 2002:ac8:5f47:0:b0:50f:bcfe:e8e0 with SMTP id
 d75a77b69052e-516c5477e17mr25147771cf.13.1779352629775; 
 Thu, 21 May 2026 01:37:09 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:bb10:ae82:b7c3:d15a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4903caede9fsm10502405e9.14.2026.05.21.01.37.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2026 01:37:09 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Thu, 21 May 2026 10:36:24 +0200
Subject: [PATCH 01/23] mfd: tps6586x: fix OF node refcount
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260521-pdev-fwnode-ref-v1-1-88c324a1b8d2@oss.qualcomm.com>
References: <20260521-pdev-fwnode-ref-v1-0-88c324a1b8d2@oss.qualcomm.com>
In-Reply-To: <20260521-pdev-fwnode-ref-v1-0-88c324a1b8d2@oss.qualcomm.com>
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
 Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
 stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1267;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=/aRY/vb3/hIBTIMJYLxhoggrOSD5XZpzRvD5IEGaQ84=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBqDsQdlJ6Gw9yankDCBt9FSOgN2Xq2huOUHVWq2
 3Mrh55a7QuJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCag7EHQAKCRAFnS7L/zaE
 w8nQD/4loqIyi5npUB0pcQ0If2+y1OYKJ5I3fRWNoD+DI2qAw7RvRg8s8P8r3CAXndoCmybnGcM
 5m1IEHBWc6qOHq0mh/OkumNuSy1hZr2x107TEzMLDEBT9H1M+UZPMvVEe/aPC79WmowHUUF9TuQ
 GP5vrZ4LpMcgS4O084BJEASA5nzY7uelq72L6TarvzcMxyS5TjdWC6urxNMBWCi8R8jZzxGqvRA
 QLmH/AE/4+uNzpnvf0hKdeOVPd6gbvE0i6b80v+PHjuoXIi/p1jUehPLgdPjIZdjebdM2TlVbq/
 P+9OrZKLw4SE+WRjUcN+UTnJ9tUAy0e3et+WqqPo3jUL89kKacqheQ1e2WkNXwGyi4uVuDNHzDN
 EvguWALMcMSEtupOOdXvE7nDWlVjqiY+3PMQILeq7NqMN/sFl6eCYnlTfomjSu+m/Em7L8Wq1ZD
 tFuwrfOg2BDxS7mr/FYdjg8+gBUNSZIL7MNlfzoXNWRl0rfwXF4Z8tdBbpD/g0zNTdhf5OZgAls
 IYx3BCJ1rkEwyphre8P9P953xIKshhJ4v9FpWul23QHiCYgcx00qs38wMQFaQ+tcpndPkewXAjf
 F/6YGVrg7Nc4nlGb9xf9H82vk+Y3HR5kALW1hO/kymu1NlKKvAubzUwld/OTrCD9MzeUjTa2CC3
 KvJGbKuQmkv3QvA==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIxMDA4MyBTYWx0ZWRfX5j0/QIA8emJ9
 pGVhx2koSd+n2eq0/p/elg9IVGNL062ujU0y724WmXVjIKYvrm0k9UyRqv3Pb1b3GP2reph+st/
 OYR/vhz7kC2+uaKXERii82TB5Jhz3XdfOuPj35QD9ncxSYfoz+9JrSzNv0Ll5RY14Uieg3CY7r/
 70Wm/xbC41I6q8QurHV2S+XgjB0fIc5UarrybGjEMQErk6iE+4RtQG+3gxsfyEFL+PgpEbAYW28
 ub7sTIJU9PRSbKbS7Veo1SpYjRTBZBr0zSlYZWkjOQrxJaEvP+NnsWrF50rbqcGz1gS0DBNChTU
 X4/qTSSyA12KBjpreswYDCJtqkCPCVj2z8k9qRtFXpelQLZj3a+10ywIPjwFkrMeEFiIHmge96p
 KzlkjD6BGsmbst5lkVHtkgrpCAguiITPx+0mR9mroO/R1V4eBq7ycpTMBikdG6Bsne+FOGFIbdo
 LPPuS0WKwMvzYpWAEGg==
X-Authority-Analysis: v=2.4 cv=Zckt8MVA c=1 sm=1 tr=0 ts=6a0ec437 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=4gvjGX-radYMG0rQGxsA:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-GUID: RjZDJT0o8pNNIhmG8gbDJvBjQS7ywKMQ
X-Proofpoint-ORIG-GUID: RjZDJT0o8pNNIhmG8gbDJvBjQS7ywKMQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-21_01,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 priorityscore=1501 malwarescore=0 clxscore=1015
 phishscore=0 bulkscore=0 lowpriorityscore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605210083
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

Platform devices created with platform_device_alloc() call
platform_device_release() when the last reference to the device's
kobject is dropped. This function calls of_node_put() unconditionally.
This works fine for devices created with platform_device_register_full()
but users of the split approach (platform_device_alloc() +
platform_device_add()) must bump the reference of the of_node they
assign manually. Add the missing call to of_node_get().

Cc: stable@vger.kernel.org
Fixes: 62f6b0879304 ("tps6586x: Add device tree support")
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/mfd/tps6586x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/tps6586x.c b/drivers/mfd/tps6586x.c
index 8d5fe2b60bfa550d0aad30acd0820fac354028ac..f5f805446603315ba76ce1fc501c908f1cec0d16 100644
--- a/drivers/mfd/tps6586x.c
+++ b/drivers/mfd/tps6586x.c
@@ -397,7 +397,7 @@ static int tps6586x_add_subdevs(struct tps6586x *tps6586x,
 
 		pdev->dev.parent = tps6586x->dev;
 		pdev->dev.platform_data = subdev->platform_data;
-		pdev->dev.of_node = subdev->of_node;
+		pdev->dev.of_node = of_node_get(subdev->of_node);
 
 		ret = platform_device_add(pdev);
 		if (ret) {

-- 
2.47.3

