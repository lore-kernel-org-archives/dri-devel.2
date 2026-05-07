Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0793ECD343B
	for <dri-devel@archiver.kernel.org>; Thu,  7 May 2026 06:23:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6C05410EF5D;
	Thu,  7 May 2026 06:23:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="M/ttAb1t";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LUXtcvT1";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CD17F10EF5D
 for <dri-devel@lists.freedesktop.org>; Thu,  7 May 2026 06:23:25 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64746HoS880640
 for <dri-devel@lists.freedesktop.org>; Thu, 7 May 2026 06:23:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=nbCDYI3s3UP
 CGmKd4YHz++jLfH6zEuiFSirImm5jJO8=; b=M/ttAb1tG0koLpwH7pqEOVJC/bA
 sfYfYwDFxxgGDm2L8tHu9on0fvbQ17ZRNRO4/SIrhmHIfaYViLFNhi+6/RPGicKk
 d8NQK+/8+HMeLPFXaKSaCYh0IZGxa5I97Ja0mIAZ2a7ZUQ9OmCW2ERn6NGp6spa9
 QxIzbL3tZqDA7J1HJJ+SNlQqH3Vcez/nxic9aMFGA7A0C7G62sZY7dJwUDpZcEiZ
 ijVeAHYYUW+JUHuq2Wjz6FrDPu3ozhKThGHOifrHDzdzcbyGUo06o3Jc/uOnx8Bc
 VXUsBLoDWLtruC5U0cw0B5EYZeVyJEjSoOcx9/pJ2kvQ56CEH7XoCQzhD0A==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e0kdq0d5u-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 07 May 2026 06:23:24 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-82f6a5b4f88so550915b3a.2
 for <dri-devel@lists.freedesktop.org>; Wed, 06 May 2026 23:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778135004; x=1778739804;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nbCDYI3s3UPCGmKd4YHz++jLfH6zEuiFSirImm5jJO8=;
 b=LUXtcvT1u4LuGEsGLSATasn7nr3uA9XD8k7h4n+Hh9cfivf45rmxq9mPhn19moonb0
 lqKHzXe5xLT+uXZBRTw/7hIYsgkEKHtyYkg82B2mpsanS6U8YUbHYHZg9ft6jYKyVAW6
 /L1EWyFLtjnDMH8+C70gzUyrY9oFbkJgT0tBNBrVHApHpyMJzOAAZzbc4b2Ewk3uL0Ek
 6XT8lGhs5m7X+orZs6YzlHHUM6MkKUzLXyhMx+vblLfPoZocdIDbtpmSCyHh2mMtyebO
 GA8QXyWMhaG+BiR8YlpPGrCqLgp5XuFWYLpuPo+PAr4PH+V6eB+C+toVdqGAshAm0GO8
 TxbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778135004; x=1778739804;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=nbCDYI3s3UPCGmKd4YHz++jLfH6zEuiFSirImm5jJO8=;
 b=bD/xi7IrV6klY1UIsacTRPDT0Q4lzlr6hJoG7/VMo51aP+uqQfv/ybwR6WpVhbeF35
 5CNsdRvxapJRmiUlQg00Pqx5Xz+vjDWoDTjKEyCAYKrH9Ft1wESsHAIhf7Boepf4cdnC
 U/iqwdFq5h4t4+hg3ZFYZnEwSDnfrsKrSlKFthUxpe6GCEbVRoz+uWiPo2utmuau5345
 eVxO/YrEzChwUjdumP3Ur7+4uEoeGPD9TayYioH7IBtlcxnV1L7NwivjVY+R+67XZ+TA
 xzX6Hk4NxseJPeYAQXOFgS8+2HK5qFA9iKnpct5Emn1OTGXtPoHPnMZgrUsA9z4Fka5G
 ny9A==
X-Forwarded-Encrypted: i=1;
 AFNElJ+aho6A3ArNw+CEBCI8Fm84Ta3vTykIk6qvyqEerL9XRE7cIGxVPbSmKdo8wx/1LDJAHigrTs8J8f8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyCI0KDaSxNv9jEwln63+VwTvF0uCK71epkuMFSCsqP8R3icy3b
 xDOI14kGBShlUYPItZV+Kmvm0lg+6VUJznRO+XCOiDsD2p/agYGEq5nCrUfXZFMOD4sWohIoZ8s
 q2/kDMvaEB53GYVobTr7OVxPgKbCGMZIY0FPFOXn1p/hyOBICOVqzZBHwJcl2FD7hOxnSkwM=
X-Gm-Gg: AeBDiev1Vo2sZJ3Jbr+tQ9hAp/vvB7gdXYTYeF7SZdjWLyeghHVzEGZJQtsCkzGz34x
 Yf8FM6CfFASYxCDBpbNOSHpsVEDgDApr7oluLJgnv7WfyaxdaU5jd3NSCNI76sLY7g3aQvuwCAy
 bdT57LIbpLjdUf8bFpuXJYulp4kdNHLKSg9CEknhkAtB9rvk1rHtFy2uKK6TGZFuN+TGyndyRZ1
 AOV99DIp/y2BYZbaWcsJY6SHMebDQb1T+bTL7RExe18dovQQkhptpOI2sre3h7pp/LB2m+nyikl
 iWi/7oPuHFzlpYan5Ze8mYyqJWf7Kt5HtYkg17vcPyYAavx+yYl6CtuClECR8mYDXkaLujEqlcu
 zRWiVDbOU5+DhVZ8IuOeYvrvhPQAPL4hZ1OQJ4xni9T2yRptWGROkqRZs8EXbYGnpYBPxvlbuCj
 vQPRWHJj34waXWQGHkI9sgeS0+/bwFkyiSMrFUn6f8Tnt8pV4=
X-Received: by 2002:a05:6a00:3918:b0:82f:7bec:2050 with SMTP id
 d2e1a72fcca58-83a5e550f4fmr6138990b3a.39.1778135003775; 
 Wed, 06 May 2026 23:23:23 -0700 (PDT)
X-Received: by 2002:a05:6a00:3918:b0:82f:7bec:2050 with SMTP id
 d2e1a72fcca58-83a5e550f4fmr6138963b3a.39.1778135003284; 
 Wed, 06 May 2026 23:23:23 -0700 (PDT)
Received: from hu-sibis-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-83965945101sm7346557b3a.13.2026.05.06.23.23.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 May 2026 23:23:22 -0700 (PDT)
From: Sibi Sankar <sibi.sankar@oss.qualcomm.com>
To: cristian.marussi@arm.com, sudeep.holla@kernel.org, cw00.choi@samsung.com, 
 kyungmin.park@samsung.com, myungjoo.ham@samsung.com,
 konradybcio@kernel.org, andersson@kernel.org
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 arm-scmi@vger.kernel.org, linux-tegra@vger.kernel.org,
 linux-pm@vger.kernel.org, dmitry.baryshkov@oss.qualcomm.com,
 jonathanh@nvidia.com, thierry.reding@kernel.org, digetx@gmail.com,
 conor+dt@kernel.org, krzk+dt@kernel.org, robh@kernel.org
Subject: [RFC V6 5/8] PM / devfreq: Add a governor for tracking remote device
 frequencies
Date: Thu,  7 May 2026 11:52:34 +0530
Message-Id: <20260507062237.78051-6-sibi.sankar@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260507062237.78051-1-sibi.sankar@oss.qualcomm.com>
References: <20260507062237.78051-1-sibi.sankar@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=P6IKQCAu c=1 sm=1 tr=0 ts=69fc2fdc cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=4aD_1Snzd4jiIFQuHjIA:9 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-ORIG-GUID: 841IIQchwNx9YKrn-L_ik45JuXn5HnR3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA3MDA2MCBTYWx0ZWRfXxVoS5okcvufa
 srKMsp/8nw18jNZ/oAzCDt/VfENKPxT7K4vHvLOTwGMywSbyCX+ODm68zneOM3LsHt12zG6A2jq
 ochLxuue2m6S5YI/B5V6i2jH6UG2wU+8O76mahGzYJU12m0nYFkum/ruQLsdrho8J4VNtpHuWlv
 /UgTc2LfHJkOC3PGsnORfwCmxYuZspXGZ+aqq5e+Jt9oF+SfNZ2sZGOnPTsojy6GkN5x75Cvf9K
 2KbzxP9Ov5WxtTHcNYEcvd2rAaH/yWgePD59GHwd9d1fXXW1iyBZrzYzb5KEL7O/IN6qY8r3hsF
 NLbB1ryLMD0lEMmtOwDCA3CWQYSVf+omu6vuVuxILnkdOth8j4DedzD8/YqEcxlaoyHvLqgZAZC
 GUeFnHD2ZXijep6CuefvpON4cqbbybukX/RUNpgoMXDxhegL2qYy1Wvv2Mrxhiuy2UoDD20p9Ne
 k7WtsPffpGt5mfaFw3A==
X-Proofpoint-GUID: 841IIQchwNx9YKrn-L_ik45JuXn5HnR3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-06_02,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 clxscore=1015 bulkscore=0 spamscore=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 priorityscore=1501
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605070060
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

On SoCs, where the governor and the mechanism to control the frequency for
devices like caches is hosted on the System Control Processor (SCP), there
exists a need track the frequency changes in a reliable way and provide
ways to tweaking parameters on the remote governor.

To address this introduce the new remote devfreq governor that provides for
a way to track the frequency changes on remote devices. It uses the newly
introduced target_freq attribute flag and track_remote flag to achieve
this.

Signed-off-by: Sibi Sankar <sibi.sankar@oss.qualcomm.com>
---
 drivers/devfreq/Kconfig           |  8 ++++
 drivers/devfreq/Makefile          |  1 +
 drivers/devfreq/governor_remote.c | 80 +++++++++++++++++++++++++++++++
 include/linux/devfreq.h           |  1 +
 4 files changed, 90 insertions(+)
 create mode 100644 drivers/devfreq/governor_remote.c

diff --git a/drivers/devfreq/Kconfig b/drivers/devfreq/Kconfig
index c999c4a1e567..2caa87554914 100644
--- a/drivers/devfreq/Kconfig
+++ b/drivers/devfreq/Kconfig
@@ -56,6 +56,14 @@ config DEVFREQ_GOV_POWERSAVE
 	  the DEVFREQ framework returns the lowest frequency available
 	  at any time.
 
+config DEVFREQ_GOV_REMOTE
+	tristate "Remote"
+	help
+	  A simple governor to track the frequency of devices whose
+	  dvfs control lies outside the kernel. This governor acts
+	  as an observer and provides for ways to track frequency and
+	  set/get information related to the remote dvfs device.
+
 config DEVFREQ_GOV_USERSPACE
 	tristate "Userspace"
 	help
diff --git a/drivers/devfreq/Makefile b/drivers/devfreq/Makefile
index 404179d79a9d..cde57c8cda76 100644
--- a/drivers/devfreq/Makefile
+++ b/drivers/devfreq/Makefile
@@ -4,6 +4,7 @@ obj-$(CONFIG_PM_DEVFREQ_EVENT)	+= devfreq-event.o
 obj-$(CONFIG_DEVFREQ_GOV_SIMPLE_ONDEMAND)	+= governor_simpleondemand.o
 obj-$(CONFIG_DEVFREQ_GOV_PERFORMANCE)	+= governor_performance.o
 obj-$(CONFIG_DEVFREQ_GOV_POWERSAVE)	+= governor_powersave.o
+obj-$(CONFIG_DEVFREQ_GOV_REMOTE)	+= governor_remote.o
 obj-$(CONFIG_DEVFREQ_GOV_USERSPACE)	+= governor_userspace.o
 obj-$(CONFIG_DEVFREQ_GOV_PASSIVE)	+= governor_passive.o
 
diff --git a/drivers/devfreq/governor_remote.c b/drivers/devfreq/governor_remote.c
new file mode 100644
index 000000000000..6bff3cdaf1e5
--- /dev/null
+++ b/drivers/devfreq/governor_remote.c
@@ -0,0 +1,80 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#include <linux/errno.h>
+#include <linux/module.h>
+#include <linux/devfreq.h>
+#include <linux/devfreq-governor.h>
+
+static int devfreq_remote_track_func(struct devfreq *devfreq, unsigned long *freq)
+{
+	unsigned long cur_freq = 0;
+
+	if (devfreq->profile->get_cur_freq)
+		devfreq->profile->get_cur_freq(devfreq->dev.parent, &cur_freq);
+
+	*freq = cur_freq;
+
+	return 0;
+}
+
+static int devfreq_remote_track_handler(struct devfreq *devfreq, unsigned int event, void *data)
+{
+	switch (event) {
+	case DEVFREQ_GOV_START:
+		devfreq_monitor_start(devfreq);
+		break;
+
+	case DEVFREQ_GOV_STOP:
+		devfreq_monitor_stop(devfreq);
+		break;
+
+	case DEVFREQ_GOV_UPDATE_INTERVAL:
+		devfreq_update_interval(devfreq, (unsigned int *)data);
+		break;
+
+	case DEVFREQ_GOV_SUSPEND:
+		devfreq_monitor_suspend(devfreq);
+		break;
+
+	case DEVFREQ_GOV_RESUME:
+		devfreq_monitor_resume(devfreq);
+		break;
+
+	default:
+		break;
+	}
+
+	return 0;
+}
+
+static struct devfreq_governor devfreq_remote_track = {
+	.name = DEVFREQ_GOV_REMOTE,
+	.attrs = DEVFREQ_GOV_ATTR_POLLING_INTERVAL
+		| DEVFREQ_GOV_ATTR_TIMER,
+	.flags = DEVFREQ_GOV_FLAG_IMMUTABLE
+		| DEVFREQ_GOV_FLAG_TRACK_REMOTE,
+	.get_target_freq = devfreq_remote_track_func,
+	.event_handler = devfreq_remote_track_handler,
+};
+
+static int __init devfreq_remote_track_init(void)
+{
+	return devfreq_add_governor(&devfreq_remote_track);
+}
+subsys_initcall(devfreq_remote_track_init);
+
+static void __exit devfreq_remote_track_exit(void)
+{
+	int ret;
+
+	ret = devfreq_remove_governor(&devfreq_remote_track);
+	if (ret)
+		pr_err("%s: failed remove governor %d\n", __func__, ret);
+}
+module_exit(devfreq_remote_track_exit);
+
+MODULE_DESCRIPTION("DEVFREQ Remote Tracking governor");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/devfreq.h b/include/linux/devfreq.h
index dc1075dc3446..4d50cf230950 100644
--- a/include/linux/devfreq.h
+++ b/include/linux/devfreq.h
@@ -21,6 +21,7 @@
 #define DEVFREQ_GOV_POWERSAVE		"powersave"
 #define DEVFREQ_GOV_USERSPACE		"userspace"
 #define DEVFREQ_GOV_PASSIVE		"passive"
+#define DEVFREQ_GOV_REMOTE		"remote"
 
 /* DEVFREQ notifier interface */
 #define DEVFREQ_TRANSITION_NOTIFIER	(0)
-- 
2.34.1

