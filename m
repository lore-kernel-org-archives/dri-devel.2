Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEF97CD5BB2
	for <dri-devel@archiver.kernel.org>; Thu, 21 May 2026 08:38:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BB8A510F28D;
	Thu, 21 May 2026 08:38:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="fw8QZ03A";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KgOPQiWc";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 998B110F290
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 08:37:56 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64L72jaW3050028
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 08:37:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 JM5WrS8FsL7s/NkKefUF2OuGPRtsF5B5mOOL733hTA0=; b=fw8QZ03AavUTjU4Q
 S3ZEST3b2vZi66clxpJ7YbdOzT1lEy0sb6r2I1Ck3VOlZOg4M2Mztk6W82f4Kvvs
 jZLIPlVuoO4nlh7Wqs+/c66Ab49g+3nB89mZqp1gAF8ahSngzWbMG+7on0fZ9YlP
 96r5mc8tTOfipeRDNZsYPXCC8PdK+rWZbnqbtYn/5kAO/MBO4CryrO30EAeszdvq
 4MNvuFSZwHrrLa7k/HvIZsKbSBTRGeglcQQwOd4iQ34Ehsq+6T3FuycqAhEzco02
 gXt4uUtg8e4RrxkRcrjBU9zhs3CpOqq7eZvJiw0NZKgu57dsDcb83OskcsFqwSkK
 FOUi9g==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e9wahrcaf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 08:37:55 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-8b1f39c5827so140858046d6.1
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 01:37:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779352675; x=1779957475;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=JM5WrS8FsL7s/NkKefUF2OuGPRtsF5B5mOOL733hTA0=;
 b=KgOPQiWcxa7DNOJ9KkDs5RvVEm7uY4B00h1ml8zHp/WoysGePkM3NJPZ4v9nFUfoNN
 zqJzmeCtqjFkhaGfuhJ6v4+HB9kXzZY3i7EzWEI2hN/yY0Wsg9pXRX5GGqbGoGkCn7x2
 1Rt9sVm2Xbu+BSgfN8QcTQp5/TPRUfKm3TnM4F5Lq7bhmu9mk90b6qABZWQTd+338ZXb
 +ktLiyloPVL4mpHFRcQSbbu6k6/++9K5b37PRFFLPS1akffilSokOE9pm6vllTvSmzxr
 DsDvutb9iVawKLNY1q66fH7UE8Zrs+8Y3oLa+hz+b5m5azhxWjBTLxKdu+cbKvsIyHkh
 rN4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779352675; x=1779957475;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=JM5WrS8FsL7s/NkKefUF2OuGPRtsF5B5mOOL733hTA0=;
 b=P+sIrdelZs9UWaDUDLCghQSJ3Y0m0S24H+5k7HdsdnBjfYxb1DkmDc8ADzQE/nsbWg
 6ayLy8EXFJDG7TNAqvZNul887RzI9JafG18zEx+uh6SIURwm5+Ubrg94hLgP2QJmJ8wT
 gbO7d9QgTWCeR4f0VlFSvdUVyDPRzemRbUNgDae3tUsFkllCRRFWcM+cnvpKtdu8xPQE
 yPxJG2arYCcgsRDI1dV92AaPPlB2W1fzAxbLOXKSCYEIlQmFUNer9QrdjobCQr+JX213
 /E9tyKxEwgCZt2SEZOdYsIQCiqzREo29Qwphw9chdxxfrEKLeN7meJqgst1+gzyl+8AI
 dcRg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9SuCWiSG3K6pCwqU4eVBdy8n2DWExZmfVHTSTEfn92kHUcRJLyq/P2MJ0gy5QHUD8Fh7s/bBdTd84=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy8VcNQ/AsFoslPJhiCsA1hOS5hGI9fPelj5TBCqE0RXDD8Ixrv
 gNTehv9p1uZ0GlHuuK6vhqVes3ILYBryxx1yTtNIqhjKOrxOllbCdM5OV7GLITzJ2rxvOd33V+E
 kLmds6LO2zaP6mfsktJcm/LmZWLJBiV0CQem8HaNCMH12JCWBIfYhKpq77wQNB8qvTJEKdnE=
X-Gm-Gg: Acq92OFwH8cEL5NX40aeJZAqsfFzCeV84QMOe9A11rvqIZpwR7/+qYkaou58SlYLQCz
 WlJ3pqEMqNNzvAcEISghiP4Ail3YfrFmzcEdg+lYhkMP5ADt1YDL3ahQnkrFtK5ZMY7D/tTf5Mt
 BSjN1bKSD4oS+k74JiDkeWwKpHtJ2cy4zNOwh2nMzgRvtJX+eaYqhJlgQgDRwrbOtpwBBBw/IFK
 Ie6r4gQJG52lXIZGXs8sUgo9jW9QGOJmlIB0LovY7btASGp4v2EFbt24X32VwFuu8eNMrd8YETo
 QWExyazu6QiIGVIT2SBlvQwpcVYgPopUemjw0TG3lshIjmtRWx/cOSWW2rsiLc326qV6TluP3wn
 XvFr/I5XD1d+TSbsiZBqaC0L3Id486hZyFWG84c/Qmz17/2RDPZs=
X-Received: by 2002:a05:622a:8418:10b0:516:c92e:68a0 with SMTP id
 d75a77b69052e-516c92e6b34mr7156211cf.60.1779352675119; 
 Thu, 21 May 2026 01:37:55 -0700 (PDT)
X-Received: by 2002:a05:622a:8418:10b0:516:c92e:68a0 with SMTP id
 d75a77b69052e-516c92e6b34mr7155691cf.60.1779352674619; 
 Thu, 21 May 2026 01:37:54 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:bb10:ae82:b7c3:d15a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4903caede9fsm10502405e9.14.2026.05.21.01.37.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2026 01:37:53 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Thu, 21 May 2026 10:36:39 +0200
Subject: [PATCH 16/23] slimbus: qcom-ngd-ctrl: use
 platform_device_set_of_node()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260521-pdev-fwnode-ref-v1-16-88c324a1b8d2@oss.qualcomm.com>
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
 Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=914;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=WNjV02xlopOt/yCOR6c1PBVV+f9PcccL6Myit6QlqNg=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBqDsQraq494NpNjsZdM6B5yhOMPpc0+cpQHRIzk
 BziCgGQMEmJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCag7EKwAKCRAFnS7L/zaE
 w4jTD/4l8BoivhRf297UcPlBF2FNgHn3SoPDZT2tcoCJ4pwYH2iOy+vtLErAAScTa0i+1UqBq12
 r/vnG58789VM/bZsVlX58HBBULss6RrXsI0b1xw8EkCBAbZgWviONlZkPl0INnnV/NQary8Ou61
 HS+Z9Bx2tUipQMxu1TR8k81/EnWgFAvXN2yn6rGm6KlEZGdPPoy+xyAPIudQCSPKNiItdIQy4UW
 L69otnhA4ShEQ1sNMuTK8FbfYGh60eKt7KSdIYr0joMsQqIDzR9lXGYSWsm6AkMFlZSeSDfPzec
 cbKOHBaPD/LZwggKavKmoyvpCN4R/mhifGK8vPPc+GHXXtl4NtFIzFPGDF+P09BUDdBTekpHXKF
 QdwNV1cr2r5NDEAGEz3fzJwU8AlGjoP67Fs3SG1KKOHS6JGuLDV5XEoMu2ujeF9D0wftPdbBnXE
 0XaON/q+Bo68CpJTJ/AKWzJGEasq8K8q/cZQtsbgg5p4M4Mc+Lh2mtvDp4O5yiWshRKBIKs5vvC
 P1+9Sr7JULlC9oNSLKd3qQazCwSqYr8qkLS4hpmeKs22LIastCqlnU5Icf8DpLIDThbnJftTd8D
 mlxLqdCStPGfHY0hJWWilamRC/5mefu2XlUg8HkNToEyOLkmMsb2VNO04VxVf3nl2joirLMPZcg
 tH1KDuWnTXUMHCQ==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIxMDA4MyBTYWx0ZWRfX+4myPFKgZKS1
 f6Kqh/88bfcCMHp4fAYmDKRdq4dfsMxoTn0aDotPhwk/WocIgSvou0Y2R/MIoL17EZhdcpvUO8l
 fxWkgxLhsHBj5KPEq1eHGq56SUKKa7B889deP1i21DB/uoniAxobT/vELbh9aYCldDhhRrbIXZB
 67YG7NLwKMOZ6kRqODrKhaDYShrZGvTwwe2g0pH+bIWaDRvYq4Ak7SgU9i+iLVRtl9EVm6hp9iH
 /2pc6lmQXCl1bwz8UCTW8RVwfLeTNRYq3CeWGL1VZToHHNBpJB6b4VWH+CFwBkZyklSTVWMIyBg
 j1A7PwtBysElaiiUq9HPMbvApZmVa2No5qQcCRZ0mH2isJ507aL7KgTO+IZ0ssfPZZ4qC4pmsml
 4PFrd027pHBIDWyW+8hIGKM4oiM5R/Dc7b/28xoVx4491bQg7Z3hPFJr0SWE3qWDlt/hajPRJcb
 sFbnaaqudQ4w/MehhjQ==
X-Proofpoint-ORIG-GUID: cn005SZ0z-wsCrTTxkRpsmTuONqrt1kp
X-Proofpoint-GUID: cn005SZ0z-wsCrTTxkRpsmTuONqrt1kp
X-Authority-Analysis: v=2.4 cv=H8LrBeYi c=1 sm=1 tr=0 ts=6a0ec463 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=zjndn8kAT0tTeq3eajEA:9 a=QEXdDO2ut3YA:10 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-21_01,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 adultscore=0 suspectscore=0
 lowpriorityscore=0 spamscore=0 impostorscore=0 malwarescore=0 bulkscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605210083
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
encapsulate the assignment of the OF node for dynamically allocated
platform devices with the provided helper.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/slimbus/qcom-ngd-ctrl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/slimbus/qcom-ngd-ctrl.c b/drivers/slimbus/qcom-ngd-ctrl.c
index 428266949fdd07ac13c5553bded891225c6e1a16..70f06981533237cb5de47a855462220050f6d82b 100644
--- a/drivers/slimbus/qcom-ngd-ctrl.c
+++ b/drivers/slimbus/qcom-ngd-ctrl.c
@@ -1542,7 +1542,7 @@ static int of_qcom_slim_ngd_register(struct device *parent,
 			kfree(ngd);
 			return ret;
 		}
-		ngd->pdev->dev.of_node = of_node_get(node);
+		platform_device_set_of_node(ngd->pdev, node);
 		ctrl->ngd = ngd;
 
 		ret = platform_device_add(ngd->pdev);

-- 
2.47.3

