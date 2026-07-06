Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C389C43458
	for <dri-devel@archiver.kernel.org>; Mon,  6 Jul 2026 12:45:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 78EDC10E92A;
	Mon,  6 Jul 2026 12:45:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="pdv8xzeb";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MAAVqhrA";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C93A410E92A
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Jul 2026 12:45:07 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 666AxMs7218465
 for <dri-devel@lists.freedesktop.org>; Mon, 6 Jul 2026 12:45:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 4ypedl6lAdelBq6beblP/gtF5+9BXsm+BYvhqSYvSm0=; b=pdv8xzeblN7EO7HG
 FH5xzwmFSqOU2Hgogzz26thWi65+vWdeyuOWD7eOyLyNa29P0b+SaswNqF9kS4FC
 KA1OVnpMYTn/40Nz2pxTYv4trMR0LigFtFqWn5NPzbosdepwcoCO7dLbSdFCU11+
 625Rv+YZ9WtsBt6QnCuBYwmabFKfoYm1Etyt6EIi5GTkcT84WTKLii+0R8U05BkP
 QzADCpTzhPgK8NnvXRccEl/Ux/Y7UZb18sHQKEENYHn17Kvs9gUu8wgAYrYfwdim
 kihEO6nIPf5AxXiTwzdTR5gncp7wXW5IQPREllLfupSbD+sMCFkBnKT21iqYXfA0
 EiG0KQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f88hs93bk-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 06 Jul 2026 12:45:06 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-92e6ed4fe99so509499185a.0
 for <dri-devel@lists.freedesktop.org>; Mon, 06 Jul 2026 05:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783341906; x=1783946706;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=4ypedl6lAdelBq6beblP/gtF5+9BXsm+BYvhqSYvSm0=;
 b=MAAVqhrAnvsfHxK/xWZMOqHaYJ6jmbNq5zdq/1W6ckV/BfbiLrM9SeHn2KBR9t1FOn
 3QFKID2bxsHtfstnHNEPWNGWp63DmcHSHbs7XQOXjKpuu3RFkSFYr5zsqksrVZR9N61D
 q2HkLqMJ2YKi78dxiW4vdNAKKe0OWmZHyLApxwBZ3jcaR8llzUNKhHAQwlF3ZL9dK38b
 yy1gGmPunw8Y1TDB/ED62hiXK4PMjJXWXecJjlj938W1AQzBJpSw2IS7PPtoqQAdgsCo
 w+rA8tGN70q/c9w7ocaWyXiQUT3mmZUqxvNmUDVWf+Q2di2gs5+8J+rWCqdA+xtKP8zy
 ipcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783341906; x=1783946706;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=4ypedl6lAdelBq6beblP/gtF5+9BXsm+BYvhqSYvSm0=;
 b=iSvf+IhCVo2wC/s4y47O960XnFAzGuLqJbkN8rL9hkO8xQ5oDaTGzO7DSrVPMAuwxN
 rkERnEMYFWHUEuQtKjwHe4k5PHRhYyi0S1DcJnDUCbYFKnz0rNdmUN66fQ3vqGVSmlF1
 x1XDutqi2i/aGa7lZsuOjBMDXhJnHHd9Gua8wb9y6EgXZ3au6kYIt+wa0kR2TRt6YF0Z
 UaQGCnouQ6Y42M8JbLvAQ2sDm0A3sE+ea6dm5+C5QYrUJ95+AfPVzuIxVPStuLPksDl4
 EaBO5MXOBNv9KpUGJ4TycXS1c80VUlzVE/9LlD4BVH8H9Vo7V3JL/S2UIej91Dy8C3HF
 er9Q==
X-Forwarded-Encrypted: i=1;
 AHgh+Roo99XtA8Ny3XuxS/doMH/vSvtlv6ohJb/4/1VM6u/kjqEIVczHJ2u24GCIA8cdrIkQ8gIoFaCqReI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwgR6Hdobiu/Nnd+Zq790mpcJMnBfNDE8ABSrj/ldr5cCOYNpi5
 kkaekSnsAhXvjpg0oeWeXcmD5rdz0sgpx9b8l9Tf8kNA4TH6lVN3tOgY1u78XuuIYEsY5yhuFzb
 rXRvhsiYKFf6PlpMh5hdYsQDRqTR3f7JiBn7xwzDoHaV+vUnVSrEN1w7SZIj7PoDKpDddP5A=
X-Gm-Gg: AfdE7cmBdkJZGzkE0MTbkexWcxcSIJsRmw6m4PWtTtmGK356YeUYSkLu9QHcQCd1T+s
 U8cN+MkNUXwfxNybJuDXHbM+nakFzFXQsNUCG5b1CIc09klCJNrMi+uKDc11mr8aXDPsxoxRwmH
 1IDIM1c20NwVNJ5Y0Y6RtQfFcHXOATxYo43rjev3B9H7t0CR/disXQ+bYwX01mZuQ4RXKq+M8md
 dU/G6jkfuInyNbGEkJJDgd7dEJG8o48YcVuIySzSETeeWrg3ezS7Z7l0t5bLuBznXjkhgcFVvYn
 ztEy+NgzRMReUqSLCfYIIS12BGANnF0+giwY0zioFNJMI2WoVv8ceSBvdbw7VHOmYZq70+hZS8s
 0Qcqn0c9wdsIRAfqPTjmEuZiAQViJyWAeANOKAAta
X-Received: by 2002:a05:620a:28d3:b0:92a:e474:92eb with SMTP id
 af79cd13be357-92ebb58d4c6mr45838285a.55.1783341905920; 
 Mon, 06 Jul 2026 05:45:05 -0700 (PDT)
X-Received: by 2002:a05:620a:28d3:b0:92a:e474:92eb with SMTP id
 af79cd13be357-92ebb58d4c6mr45828885a.55.1783341905233; 
 Mon, 06 Jul 2026 05:45:05 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:86f0:c42b:ef4c:d3bb])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47aa0a55be4sm22126539f8f.31.2026.07.06.05.45.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jul 2026 05:45:04 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Mon, 06 Jul 2026 14:44:17 +0200
Subject: [PATCH v3 05/20] driver core: update kerneldoc for
 platform_device_alloc()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260706-pdev-fwnode-ref-v3-5-1ff028e33779@oss.qualcomm.com>
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
 Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
 Manuel Ebner <manuelebner@mailbox.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1416;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=Jgf74WxLCxW5Zz726nCnOm1WawVwm90mJr+JyHWzTfo=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBqS6Mye7m4WIbR8PkDTH2c4X+IwaDKU66SIcDpL
 mQAGRuCAsaJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCakujMgAKCRAFnS7L/zaE
 w4ZfEAC41Mo4fJZG469yMU0Of0D0DGwRVaKN4uoZLlhdTRAcVxaepoBujUjtupSZqXiayqNHV5U
 gi5UTfW3wn++NDJyYjf09qZKyCOyEnE/UmdnwGURK5nJ+PshyBSYME0avY5FZHKVYTCIXlPzGqF
 UHC6t7eVnwL46lXo0kHJ7EsWs4t3tAPczpks24WUn0sdkVu3uPWOSTcCd94HIBE4WBs5ytMBh/+
 /FrSJqgIth1+QT2DtNBUdqqbCdI8jabVZp3kRhU2DP/pDsdKfBtljH8QRtloSKXSAddgv+vDvmZ
 5KdXc433Hkh/oTWAw8jbFbKHe67pgQKXGKko6LXTH77itBDpywUUWcIk/qEbCKQgqCku3xTgHZP
 H+H4trXem4YILFtiNbwsiQFtaD9iv124/YqQzguOiNSJYYbneWqaJUXkLzRdiHcklMRySNnUQ1Z
 zzlY+2vbp7eQSY7hvbHjthXmH7V3pryL4Y7yDI+OaiYJcYu8ca/YbMP5Lq2mqASntQtP0qTkBwv
 WlH7HQjT0H2v8cocaoPHpRRmZ6FmkINXxIXvK+awAkiCuscSrZeN9lSC36RmTZANo+qHicYPUm3
 0ymNHLd9ZEW7+c55YFCw8msnV5MMfdIaQF6xsNtguNg6ayHTyrtqvt38bkFvNglpZCmrVFxNFQ6
 Ysws8qDm8bTfJYQ==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-ORIG-GUID: jDeaDG-IrD82upr72MxiSiBggRfbrUGk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDEyOSBTYWx0ZWRfX3pnbeHwEuOKk
 sOnV2YpufVDSz5hX8DkKLI2pxfGdZHwIJ+pwnBQfyuMvjXuk+50R/IQ+bw1D7h5909xU8hbokos
 5h5w+f9+3y5kgLoTDiTdUE1dmDijW/UtPUeXuUIw7ENyActlaiFcw6EtKIx6h1VgmKhjsL4FMgD
 PUH3ouPukylUgv6H5+sLjXjmpdTxJj1soS4lqFpnotcAu+omHwZW2BLGedW3lmkylboMGnI+SSm
 Nlg5N8Fogt8CpTZm/BA4M02IzziUUKxfzqrIzqqKw/VgOC3hUixESdi95Zcor/TMJeJt1cMrQAm
 VbJ+y4C1uSAMXtYO/5vvZKrVD3qPaCEyHIs4JemLHvI20zNvDnGLbfWPxN0cPuCIS5v5erdEuWb
 ADTH6MkqsEyUYDdX4Z85e8zK1PRwjyyXvaGBfD5SRSP7Z4hLckwHbMef4WFTxxazXQAj7R7uKpH
 +lWZYtii4SPzSh9ZRLA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDEyOSBTYWx0ZWRfX7Jh+xjgSjgk3
 Ne+hOd2QPpSlHhLmSONow3ylunZdOmxJKO7+u6J4HW9SHVKAo26kE0b2lvDz7aB0m0P7Hr0f/XW
 gCW/ZkJm2OzSOeJA0/JpMwhmprG+JGw=
X-Authority-Analysis: v=2.4 cv=XIwAjwhE c=1 sm=1 tr=0 ts=6a4ba352 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=b3CbU_ItAAAA:8
 a=EUspDBNiAAAA:8 a=1vxtNpAeqxpoFZHZEuYA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22 a=Rv2g8BkzVjQTVhhssdqe:22
X-Proofpoint-GUID: jDeaDG-IrD82upr72MxiSiBggRfbrUGk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_01,2026-07-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 bulkscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 lowpriorityscore=0 spamscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060129
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

Users of platform_device_alloc() + platform_device_add() must not modify
certain fields of the dynamically created platform device object. Update
the kernel doc to say which fields are affected and which functions to
use.

Suggested-by: Manuel Ebner <manuelebner@mailbox.org>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/base/platform.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index f24a5f406746b53ca9eaab9472f6dd1345e04ad6..9357942d0c79b032645035879b2bed3d53305b9f 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -619,6 +619,13 @@ static void platform_device_release_full(struct device *dev)
  *
  * Create a platform device object which can have other objects attached
  * to it, and which will have attached objects freed when it is released.
+ *
+ * The following fields of the dynamically allocated platform device must not
+ * be modified manually: resource, num_resources, dev.platform_data,
+ * dev.of_node and dev.fwnode. Users wishing to do the split platform device
+ * registration with platform_device_alloc() + platform_device_add() are
+ * required to use dedicated helpers for adding resources, platform data or
+ * assigning firmware nodes.
  */
 struct platform_device *platform_device_alloc(const char *name, int id)
 {

-- 
2.47.3

