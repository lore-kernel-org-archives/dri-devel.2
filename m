Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0901C43458
	for <dri-devel@archiver.kernel.org>; Fri,  3 Jul 2026 19:39:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1B36510E65B;
	Fri,  3 Jul 2026 19:39:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="iZuu44D6";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XzDMRgBX";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B6FA210E65B
 for <dri-devel@lists.freedesktop.org>; Fri,  3 Jul 2026 19:39:51 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 663HiOPX695414
 for <dri-devel@lists.freedesktop.org>; Fri, 3 Jul 2026 19:39:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=kAqGWShsALr
 UvOo44yJ9PZPqBuVxxzDIDv0SXARnsDY=; b=iZuu44D62fDE9nUkMGsQ/kikCWN
 vJtcLEgw6+dGCeIIHuOlMsUIpFKZZGJPJqfdF+O1SYEhJ9Ewxr3bmWpbtRmLiIqQ
 jYkNIvEv+KCpR6MtdXix1MGky2N2ZQ+IKKh/NsqwJzV4809aM+q8nNtoVSj4h9GS
 7ZOJF8MX23ckx9HxrND4qmrfOFK47QtXOdWwXxI5gur6l6dxQmmA/LR6so3jKGq/
 W7A00TMFaZJ0ko+VVC0tHFFvu0ryV81DeIP4S6UmjKnzb0SJmxCATCZFjAZe9zfa
 KCzmbOBkJT97xvyMzhw69zt86W2jJf7+4G93pb8Mz+QzA56HX9qkqRm3E6A==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f6a84a511-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 03 Jul 2026 19:39:51 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-38127ae6b99so1224566a91.1
 for <dri-devel@lists.freedesktop.org>; Fri, 03 Jul 2026 12:39:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783107590; x=1783712390;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kAqGWShsALrUvOo44yJ9PZPqBuVxxzDIDv0SXARnsDY=;
 b=XzDMRgBXU1a+rNJgp57IfN8Q9V41y4FOTE012QTtgWcOgA3rzh7QmmAoCBUpBjkULz
 npNNDlY5fbnBuWU7yPjGJVQoPQ7E8Xf2iT3nlKB7l0S4is6AWg91ZfZcHi/zvn+j1dSi
 YHUOPxCLR2UfvrwLaRGa7kwiawtITLTMYH3CD9hK0AgWFkuT+wdFUQeumBkcxs31XVwg
 H3Jn94PRhfnsW8LWlVSjvnMURTYr1mc9XEhkvYPoFFdKgsIxB5PNuEme2XI8Je5j62sQ
 k5iIPJESXhiDYrhogEsaQDA0wdWuwZ6LC84BX1ni1GeMr6NEMo3w3kp/DAmc/KI6AZoV
 1o5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783107590; x=1783712390;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=kAqGWShsALrUvOo44yJ9PZPqBuVxxzDIDv0SXARnsDY=;
 b=qlaT1BwAHmFSSiCRfvArkFJ9YT1dKvbiP0msEXpVPNscdOmp6myBMF/9g2ic+gVitZ
 T3h22Ngv4Lp/U+MbjSfKp+iG5RsAwDebl/GsL28rvz5W+euZIa2lPF7tVTsgCSkBxMfq
 k4KDCUUctcYr6pGrtOmqAuiFcczhDTkvKFAc9gv+O0oq/PT25dZw2u1mHB7rkoJfBs0u
 CNOdyb0+Hh7/tJnyN/ntZxGDd95xalQNmyLrhC282xUBbnJ2xOWEO98XZhm+3jrj4Qlu
 Mcm0IMS8vZIbUjGAqJVwqa3SZaYyhFrcNidsnwrMXCaMxEhy7lp94KKRUxspWLj5chcX
 s6qw==
X-Forwarded-Encrypted: i=1;
 AHgh+RqSomyGQpktAwpdwrLWbH1XtXiVj4kMMnicljZbAZcQ8WKUijUH/w2yYMmzVlUvqD/zgRGQaxMNnX0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyLEJaBrEkK5EHTtBZsRNHptz5BlvaztfxS8liztK30myGzB2t1
 Rrctj71T5Ai/XOYt0ErdlHO2lLKTnyD+tm5zNZiYtHfBZfW++yilGPHOH4MxqWUK0klvs+8AaUH
 5SCkM6eYj5eNNuGWg1b3h6vppvH+NJbasrvkl/Z4F4x5pmrF6mviS4ESpcnWzmfU1mPs3O6g=
X-Gm-Gg: AfdE7cmdmtxs0dbEdJ42JXaTYmQhCZPn3gZ1dO4KKuDv3/dswGZ6lst46ktS9sWR/AJ
 tMi/PD57qURML/vovdx2lhB8Q5KgLtrPworNL165IE8pwOehaW+P9K30vGK7GpTKW63Z+fMm9eO
 nkglhjz8fqClVMuvBnh75Qtqsm2k1vXAkuDjb06TPIVKeYCQN2r/CM+Snb1GugSSU1Le95viAfV
 32AtUUAdb7LAfDRlag1qfmcpzFXoAv7Mb7rujVXYaVBU+L4PwLmnuJ706ekh6e1RSzsCD1Kk+UQ
 xltG/kta3QCsK21eQxsMkmt1P805/IpOOhjqjcHa+19Guyy9voQVW72sJsEm/dfd2DxpS41ASIw
 vo74JNPekN8g7qGRQ1xUOB7ObcETOu11rdtV5mg==
X-Received: by 2002:a17:90a:e70c:b0:380:ce69:2669 with SMTP id
 98e67ed59e1d1-381122ebda9mr5933731a91.9.1783107590248; 
 Fri, 03 Jul 2026 12:39:50 -0700 (PDT)
X-Received: by 2002:a17:90a:e70c:b0:380:ce69:2669 with SMTP id
 98e67ed59e1d1-381122ebda9mr5933658a91.9.1783107589588; 
 Fri, 03 Jul 2026 12:39:49 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30f290b6bc2sm10065845eec.27.2026.07.03.12.39.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Jul 2026 12:39:49 -0700 (PDT)
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Liviu Dudau <liviu.dudau@arm.com>,
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
 Michal Simek <michal.simek@amd.com>,
 Daniel Scally <dan.scally@ideasonboard.com>,
 Jacopo Mondi <jacopo.mondi@ideasonboard.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Eddie James <eajames@linux.ibm.com>,
 Tiffany Lin <tiffany.lin@mediatek.com>,
 Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
 Yunfei Dong <yunfei.dong@mediatek.com>,
 Minghsiu Tsai <minghsiu.tsai@mediatek.com>,
 Houlong Wei <houlong.wei@mediatek.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Joseph Liu <kwliu@nuvoton.com>, Marvin Lin <kflin@nuvoton.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Krzysztof Kozlowski <krzk@kernel.org>,
 Thierry Reding <thierry.reding@kernel.org>,
 Jonathan Hunter <jonathanh@nvidia.com>,
 Srinivas Kandagatla <srini@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Ge Gordon <gordon.ge@bst.ai>, Adrian Hunter <adrian.hunter@intel.com>,
 Ulf Hansson <ulfh@kernel.org>, Rob Herring <robh@kernel.org>,
 Saravana Kannan <saravanak@kernel.org>,
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Shengjiu Wang <shengjiu.wang@gmail.com>,
 Xiubo Li <Xiubo.Lee@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Frank Li <Frank.Li@nxp.com>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
 Bard Liao <yung-chuan.liao@linux.intel.com>,
 Daniel Baluta <daniel.baluta@nxp.com>, Orson Zhai <orsonzhai@gmail.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 Peter Chen <peter.chen@cixtech.com>, Fugang Duan <fugang.duan@cixtech.com>
Cc: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>,
 BST Linux Kernel Upstream Group <bst-upstream@bstai.top>,
 Fabio Estevam <festevam@gmail.com>, Nicolin Chen <nicoleotsuka@gmail.com>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
 Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
 Chunyan Zhang <zhang.lyra@gmail.com>,
 CIX Linux Kernel Upstream Group <cix-kernel-upstream@cixtech.com>,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-aspeed@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
 linux-sunxi@lists.linux.dev, linux-media@vger.kernel.org,
 openbmc@lists.ozlabs.org, linux-mediatek@lists.infradead.org,
 kernel@collabora.com, linux-tegra@vger.kernel.org,
 linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-remoteproc@vger.kernel.org, linux-staging@lists.linux.dev,
 linux-sound@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 imx@lists.linux.dev, sound-open-firmware@alsa-project.org,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
Subject: [PATCH 01/42] of: reserved_mem: Introduce devres-managed
 initialization functions
Date: Sat,  4 Jul 2026 01:08:14 +0530
Message-ID: <20260703193855.110619-2-mukesh.ojha@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260703193855.110619-1-mukesh.ojha@oss.qualcomm.com>
References: <20260703193855.110619-1-mukesh.ojha@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: gAkndqV00wepp9y7KCMOjPE-jOyT-lMG
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDE5OCBTYWx0ZWRfX+FJpnHRq4BJU
 V4gZRPS68wa6CGK4ZsLOQBiFYd8y2fpjEEGitB/17YlhSWp3LHsHruCR2LU9qUMzo2dQ9d+pick
 rYnhDtlB/YSSlwxbQiGXwWG5ocN7BqA=
X-Authority-Analysis: v=2.4 cv=a6QAM0SF c=1 sm=1 tr=0 ts=6a481007 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=C96w-YAaP-Zupzk_Mv8A:9 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDE5OCBTYWx0ZWRfX2dEK6S+Fv6FD
 V7LGg+07z7Y4dtmokBkEZH5P5HTzIplnEn0kuMfpSYDfLHgkId57mWL3iPaa9FrDZQQ91ZEVPdj
 G5uI8kI6oAn8vTBK6QC2dqzNWsK5vDH+I5tHfTIdLkFtbN9lGQ9/e3b3zMgrNyMDv/5sRcBJfLA
 ffg8aFoVLzwsyQnxRf2mJlGMVUgYbK5kTJic+JSwcV7N0lrJF11oU0/beE6nHG9mQn1bLQ5QHBE
 ffwttmCzos0CV5XnWVbaIQjN/dMF5xtOvwRz+Dq8axlyFiVgkZ2ABMFxxyFur5gFdMN8M0MjsPV
 fYJ4tr6EgS/GNbOyx3Qvdjal86Zneys7cjdSK1STkFDB5iJFOPSWo0JdRQ0+EvL8jeZKVkojdk+
 LZzo53BZFcQNTaYB6diw+kXJ7CXhWNQH2sWPfUIQ6m0BLxlzpTACGpmY1d8ZEDZR/h3qUzPTrsK
 Odlop+Ikroo1LCltEig==
X-Proofpoint-ORIG-GUID: gAkndqV00wepp9y7KCMOjPE-jOyT-lMG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_03,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0
 bulkscore=0 impostorscore=0 phishscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607030198
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

From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Introduce devres-based helpers for of_reserved_mem_device_init(_by_idx)
to help fight dangling references and ever so slightly reduce the
number of boilerplate deinitialization calls.

Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
---
 drivers/of/of_reserved_mem.c    | 41 +++++++++++++++++++++++++++++++++
 include/linux/of_reserved_mem.h | 25 ++++++++++++++++++++
 2 files changed, 66 insertions(+)

diff --git a/drivers/of/of_reserved_mem.c b/drivers/of/of_reserved_mem.c
index 82222bd45ac6..b35541e9fbe8 100644
--- a/drivers/of/of_reserved_mem.c
+++ b/drivers/of/of_reserved_mem.c
@@ -787,6 +787,47 @@ void of_reserved_mem_device_release(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(of_reserved_mem_device_release);
 
+static void devm_of_reserved_mem_device_release(struct device *dev, void *res)
+{
+	of_reserved_mem_device_release(*(struct device **)res);
+}
+
+/**
+ * devm_of_reserved_mem_device_init_by_idx() - Resource managed of_reserved_mem_device_init_by_idx()
+ * @dev: Pointer to the device to configure
+ * @np: Pointer to the device node with 'memory-region' property
+ * @idx: Index of selected region
+ *
+ * This is a resource managed version of of_reserved_mem_device_init_by_idx().
+ * The reserved memory region will be released automatically when the device
+ * is unbound.
+ *
+ * Returns: Negative errno on failure or zero on success.
+ */
+int devm_of_reserved_mem_device_init_by_idx(struct device *dev,
+					    struct device_node *np, int idx)
+{
+	struct device **ptr;
+	int ret;
+
+	ptr = devres_alloc(devm_of_reserved_mem_device_release, sizeof(*ptr),
+			   GFP_KERNEL);
+	if (!ptr)
+		return -ENOMEM;
+
+	ret = of_reserved_mem_device_init_by_idx(dev, np, idx);
+	if (ret) {
+		devres_free(ptr);
+		return ret;
+	}
+
+	*ptr = dev;
+	devres_add(dev, ptr);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(devm_of_reserved_mem_device_init_by_idx);
+
 /**
  * of_reserved_mem_lookup() - acquire reserved_mem from a device node
  * @np:		node pointer of the desired reserved-memory region
diff --git a/include/linux/of_reserved_mem.h b/include/linux/of_reserved_mem.h
index e8b20b29fa68..b9fd78123d77 100644
--- a/include/linux/of_reserved_mem.h
+++ b/include/linux/of_reserved_mem.h
@@ -40,6 +40,9 @@ int of_reserved_mem_device_init_by_name(struct device *dev,
 					const char *name);
 void of_reserved_mem_device_release(struct device *dev);
 
+int devm_of_reserved_mem_device_init_by_idx(struct device *dev,
+					    struct device_node *np, int idx);
+
 struct reserved_mem *of_reserved_mem_lookup(struct device_node *np);
 int of_reserved_mem_region_to_resource(const struct device_node *np,
 				       unsigned int idx, struct resource *res);
@@ -68,6 +71,13 @@ static inline int of_reserved_mem_device_init_by_name(struct device *dev,
 
 static inline void of_reserved_mem_device_release(struct device *pdev) { }
 
+static inline int devm_of_reserved_mem_device_init_by_idx(struct device *dev,
+							  struct device_node *np,
+							  int idx)
+{
+	return -EOPNOTSUPP;
+}
+
 static inline struct reserved_mem *of_reserved_mem_lookup(struct device_node *np)
 {
 	return NULL;
@@ -108,4 +118,19 @@ static inline int of_reserved_mem_device_init(struct device *dev)
 	return of_reserved_mem_device_init_by_idx(dev, dev->of_node, 0);
 }
 
+/**
+ * devm_of_reserved_mem_device_init() - Resource managed version of of_reserved_mem_device_init()
+ * @dev:	Pointer to the device to configure
+ *
+ * This is a resource managed version of of_reserved_mem_device_init().
+ * The reserved memory region will be released automatically when the device
+ * is unbound.
+ *
+ * Returns error code or zero on success.
+ */
+static inline int devm_of_reserved_mem_device_init(struct device *dev)
+{
+	return devm_of_reserved_mem_device_init_by_idx(dev, dev->of_node, 0);
+}
+
 #endif /* __OF_RESERVED_MEM_H */
-- 
2.53.0

