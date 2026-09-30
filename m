Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2EE3CA5FAC
	for <dri-devel@archiver.kernel.org>; Wed, 30 Sep 2026 12:44:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 39EC110EA16;
	Wed, 30 Sep 2026 12:44:30 +0000 (UTC)
Received: from bg1.exmail.qq.com (bg1.exmail.qq.com [114.132.67.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5064C10E9FB;
 Wed, 30 Sep 2026 12:44:28 +0000 (UTC)
X-QQ-mid: zesmtpip3t1790772169t64b28dbf
X-QQ-Originating-IP: qDMJQCvc/X6gK9EeyapjuZFtWVRaYsWr0gWkAsEZfQI=
Received: from [192.168.30.32] ( [localhost]) by bizesmtp.qq.com (ESMTP) with 
 id ; Wed, 30 Sep 2026 20:42:47 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 4880174641488719103
EX-QQ-RecipientCnt: 16
From: Xilin Wu <sophon@radxa.com>
Date: Wed, 30 Sep 2026 20:41:55 +0800
Subject: [PATCH 11/13] drm/msm/dp: Initialize the debugfs connector pointer
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260930-msm-dp-hdr10-v1-11-dbbf8b2b42bc@radxa.com>
References: <20260930-msm-dp-hdr10-v1-0-dbbf8b2b42bc@radxa.com>
In-Reply-To: <20260930-msm-dp-hdr10-v1-0-dbbf8b2b42bc@radxa.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Clark <robin.clark@oss.qualcomm.com>, 
 Dmitry Baryshkov <lumag@kernel.org>, 
 Abhinav Kumar <abhinav.kumar@linux.dev>, 
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org, 
 Xilin Wu <sophon@radxa.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=981; i=sophon@radxa.com;
 h=from:subject:message-id; bh=NGqdnwnUvBZxVA1GeH0SjjfBXNw7+fXjQR75iosVxoQ=;
 b=owGbwMvMwCVmdFg0fe08Iz/G02pJDFl7mZdlzLFyrc/fJpq90WjZ+jd7FcLOf9y48WSzV3FA3
 qrPVWu7OkpZGMS4GGTFFFkU4hnmslfmXnsqVqoHM4eVCWQIAxenAEzk6BtGhgPz5hQen8QrtTtF
 I3zH7fdpbyy/VzYsX/luTuGicwZL4+8y/A9K583hFrg2JfKHs+tWgwlu66wcov722W/R3/clmLd
 mDQsA
X-Developer-Key: i=sophon@radxa.com; a=openpgp;
 fpr=205F009D07796DD6E516752E32C31567AD9E324E
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:radxa.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: NK7Q3LAmFwd9hNTG4FvWom1ENpG2QGzwqdv8e/fdgJvBS/MA4c/odbLR
 bO7J3+y4YxpcH2aOe8tCjyIX5wFM3WkINufvL5+E7Uze6SiQJx0lAVHbzcGEWWXmV8ziVQ9
 qJ2aGmIjT0CQmerc3w6iOj/B7HJRGHln8TyHdW/Xnx/7Wg0Ir5X3HOslV9a6Tn/oI/qL+3D
 IOM4n7vdUmjAHpDNl6MPJ7hu482s/z5wwMXUqQ36Zg51SgXL58NTHEvVvWkAm9QUNYdUPr7
 gVHMONJ6iaxbqwlvWb09q2O3yGOYhg0Lh4dDA78wKeejg8RnvsQG+A+HxMOxnBkCePEGm7h
 884rUny5+IOuFILnZ0gdKl6OACXlWSxk0+A7ULIT/Aza6s3T1o40ePET/mroRjScYpq+Dle
 PoFcB1/rGHA223kcpWqcplWKtMULVtwcvNol+f6+C+9k42F4MWtpTUhHW2e1bHXULkxXR7M
 qs2XRdeylP4Q92Gwvh5aLtraZ2W5jo+covdXi/6PPhDHNEQyUfjB/wKbi8yc1oi4oAwkrA2
 3dc1+3cUa4Ea9sxt8dEtgG6kuMfrhPnPIayQJvfFQfn5TC4JhSkRUm0wJizpm/T9S8fMD6+
 w3xSjgUtGvfL0xqEUEq4l5L5l3lnhtjxy5eAQAuJ+K5I5tGeDV7QE409gMqRnLfid7eQmwU
 b1BgigHd/ooBx3+Vj4A2ty111ioF/8E3byPd0wbifuIkHIAXT95OHYpFFlI5EfPkEWR+mPp
 A2IAw7BnZXUMLq11M25at1rk5fmqv6L8FpPVqb79xZXFQ2LoeFNe/WuWwg2/TMj6hS1kzng
 AW5SQkKe2OxIEYzJbeo1DiVbjGPCRPbHIRUAfDrCPpkGTQOZSuMp3oD5maSpeO45ovmgoeC
 zAEopGtkUXRWJE6lx5m3K0DZfGpBvCwKasWMpiPBdPzeHq7e9ForW7LDR+yIBarI7qvebN3
 CW6yfmcW29oithr0dbT7N/m3BbRd3eutV8EwxSOTeipLplzivXwgUzUHeB5vhyE1ycUwApO
 2OvH5Rh2wJiwl4iOqNVcZia+f4HVMmb2or/oaY3dk/qZ21CjH3CbiBbbdsbhQNZ144TNZ1S
 fm83bbEvS0g/8lXncrPPp8=
X-QQ-XMRINFO: OWPUhxQsoeAVwkVaQIEGSKwwgKCxK/fD5g==
X-QQ-RECHKSPAM: 0
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

The debugfs cleanup removed the connector assignment from the debug
context, but the video-pattern test files still dereference that pointer
to check connector status. Reading those files can therefore dereference
NULL.

Store the supplied connector before creating the debugfs files.

Fixes: ab8420418c2e ("drm/msm/dp: cleanup debugfs handling")

Assisted-by: LLM
Signed-off-by: Xilin Wu <sophon@radxa.com>
---
 drivers/gpu/drm/msm/dp/dp_debug.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/msm/dp/dp_debug.c b/drivers/gpu/drm/msm/dp/dp_debug.c
index cf3838fcd154..00fb1a7ba40e 100644
--- a/drivers/gpu/drm/msm/dp/dp_debug.c
+++ b/drivers/gpu/drm/msm/dp/dp_debug.c
@@ -216,6 +216,7 @@ int msm_dp_debug_init(struct device *dev, struct msm_dp_panel *panel,
 
 	debug->link = link;
 	debug->panel = panel;
+	debug->connector = connector;
 
 	debugfs_create_file("dp_debug", 0444, root,
 			debug, &msm_dp_debug_fops);

-- 
2.55.0

