Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74806606A325
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 08:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=oUGjqceR;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Jc9VkDuo
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D3CB1112173;
	Thu, 19 Nov 2026 08:27:13 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 82373112170
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 08:27:00 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AJ6v4XC1962340
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 08:27:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 H7EyAW8gIZSrszNFTN7k6+v3oo0t52OnzoPD2MAjtew=; b=oUGjqceRv3pdtJfP
 viq1yj4xZt8AJF5HtctmfYOqGmcstEHoGd/enIe0GPiO8MXHOZGZA7gpntwk1DWI
 jBn8hJZ49msAelEQk3ZgJ/dyQdZU0zcGnQI1DgXVOySgyx7UudM05ZjOZqEd4lb3
 MHWw+Jg6lCkW2ygE1Lq+9MiqNO234c3BOOSmQowJi0anVB42ieVOVXj8FJ+ZuwRp
 /eoSM7kWzryAfRRsmdUPNkyH1VtzKNHDkbLMMhXA3ZYqitmfNzBH1jJRlmxnmjTX
 5UB6g4PM7JCMPUDG84ilub7d7SxTRFujdwxxGoufrowH9kqsgz0SN55+p18WUuBP
 ZbFHEw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j1gxcu95f-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 08:26:59 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-949b0d322fbso39559285a.3
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 00:26:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795076819; x=1795681619;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=H7EyAW8gIZSrszNFTN7k6+v3oo0t52OnzoPD2MAjtew=;
 b=Jc9VkDuoXyVxSD70lDqfxCW6NbWS/ecgHUGmjy8xJ1m6qZvXg1ko1PktGwtB3IYzJK
 a3qGZu+LbdekoNfVH+8tmziW410mkyPfTIhSW2xaT4qPhXBIx3KtbyGrA+XSewmK8wA9
 SoA8858t87v/km0Kj3bVc+/ciWYqtL0BBSBdhfiPjBZz53CwZGzrMWCsUKItx3u093pS
 CGj115z2yllrSb0odu5pahKFrgYxXZbB+kDT0Cqv1ai2KYaJi383oEiBh8JpQwj0dqaP
 olQguRRvDNcNzvhsHACVTi3JFeashBjG8lO53DGHYRDgINdwDqi7DkCmH2VjFM87MR1F
 QxkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795076819; x=1795681619;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=H7EyAW8gIZSrszNFTN7k6+v3oo0t52OnzoPD2MAjtew=;
 b=VEB2mG7VwOvm0z6qpTJmPNfGkBVMpJ4DRZN5Zo2Yg46e4A6YPO5Ym63UBlLWVOPkfA
 ChEe40FmsmHkLz8c4CUkmVqxDWRf4Pee7BjVdmD7JFU4LNZKS/79OZ4I6v0Jcfnh0iH7
 TRdp/DwG7XJ4Ku0Xh53sTPeuoFbFKSyvDsXO7n0S9kT7ILL9doSyzY3E4NFRWLidND2z
 7W5dMnP8jmDFetFI9edW9M0oMMn/KCYY18iqqbJtEVLn6QgLRLGVCs7QrF11hkQ74bAR
 gJqfJ7aUQKB9EcuhkREaQ3cKc7bufJpGP5LSOHQm0S4nQWRej5bLpsqBeiTaRzWZxIn+
 BGvg==
X-Forwarded-Encrypted: i=1;
 AL+hErHh9LaeVJvQLQZHdNer+qz/Ke9G69rQJbnR3xk6Y9r/uZvcrPXP6dS2zI55kMwfeDSJg/yPoZ3fKqg=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+m+VCcdpJE/729eRNmVMs9abK4QHSVbbvdCzjMF7XWdY7ahIo2
 vs4/ji0qQA7Wj1+GWywrGmbWWCcsTDsVPFOSuxwsWtppkuHJGD5JSZjG8sdV7YZoBVtLaVPPkNl
 0gtCvpZtsLKcwKRUX3lTHk6vKvsrKpEdQx06Bxh+247W8D9JI1oJ999A1UlycXGfuxLZMRi0=
X-Gm-Gg: AYBFou3p+mIfM8SOHWuheqS7nboPW577ifLo22iaxEsW2fvQvG2gvJfV37frdzApurG
 JOUsV0q8Ul3S7O/kekfGkOEsl9SgJs2kWaokUrLXYVuxUk8MZsvBqmuVG1A570KXSVhP/3uJDIf
 WQtMqUZHgh5a2zFxvdezW5MOCV3DC1hM/bhiG1bGmxSIP9DgsEtoYwdgLwjRR7gszMXbtveG16o
 s0zbDojX0Z5Dlx4pjIGxuF4ESmalyO3Xv4y0iAQh9iNrpZTaJ0DX7k35V8r1pwNWf84HkaV5jKc
 nTjZnAmW0fk130/x7Eu+TD6f4Mx5eiljJxWm95DKWYbSaRHxqD+kfOUwAbsEjzaVmDgEMO5i7OY
 eR4hSUlBRLy14RZZNL6XfTyjl82dFjAxSNheKMWyLY/Z6+8E3jgLxI8Gy99h/lY88uxF/Eui8/A
 tHFVZ6+a5E0H3RTfftyjpnJO6BWTsWcmAgLtyd
X-Received: by 2002:a05:620a:6c18:b0:93c:a191:88fe with SMTP id
 af79cd13be357-949994af046mr819247185a.8.1795076818731; 
 Thu, 19 Nov 2026 00:26:58 -0800 (PST)
X-Received: by 2002:a05:620a:6c18:b0:93c:a191:88fe with SMTP id
 af79cd13be357-949994af046mr819244585a.8.1795076818214; 
 Thu, 19 Nov 2026 00:26:58 -0800 (PST)
Received: from yongmou2.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9499b721861sm388465185a.11.2026.11.19.00.26.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Nov 2026 00:26:57 -0800 (PST)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Thu, 19 Nov 2026 16:24:31 +0800
Subject: [PATCH v9 29/29] soc: qcom: pmic-glink-altmode: skip retimer reset
 on DP IRQ
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261119-msm-dp-mst-v9-29-ca61be4edfc3@oss.qualcomm.com>
References: <20261119-msm-dp-mst-v9-0-ca61be4edfc3@oss.qualcomm.com>
In-Reply-To: <20261119-msm-dp-mst-v9-0-ca61be4edfc3@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jessica Zhang <jesszhan0024@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Yongxing Mou <yongxing.mou@oss.qualcomm.com>,
 Abel Vesa <abel.vesa@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795076662; l=4168;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=TmXXqL4+QkkVPUU1CXlnanGogNfSgc71YZHywrBoGyI=;
 b=Q6I/JovIIdyQKcMt76CYQBhCV4JoyljJDor7HDEc2HiMNCQP6UyyM96jcJoOWA0eC0gdcjaRM
 HACmEwkMUp+DL95zkJnPY4uvoH+mfs0sYxtG+8bDNjtQjC26l8aCSQA
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
X-Authority-Analysis: v=2.4 cv=LZapeTfi c=1 sm=1 tr=0 ts=6afeb2d3 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=rzLW7fUJNTnmvIt_Je4A:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-ORIG-GUID: H25Jfel8QtXxdktSjDI1K2ySGkdsKd21
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE5MDAzMyBTYWx0ZWRfX5c41Sulk9lRZ
 rk1qoKcfON1sNBbLji6sVWwmf6PCUWafah3siPd/oABnp01Z0jQeKzXb8OHukNKBQ/ZW+omynh+
 d3tSrIiku/cKZadITGDoQtd2hdD4wQCQ9/PV+mBO7y96N6cZ67K5TtmR2EXUYodZjxy3OX3e2Ol
 65X4wdRvjgBkGpvTLLX2SuGanwulDFbyfu0ygdd0lzzXehvab/xvDQCTjCi0z6bUAQwCj5C8KoM
 MaNOfsRtnFv0qqTmYDq0XMK72i4BJQAbOgosT0dIbEw4ZihhT94r8zrHPC1/O1XQ2wuP9xCbbPv
 lH+tjzbPBwDn9PLm8zibpAVTyZrzXoWA8qhEKHJNxeRPIIYFDoEIBdIkQZh2jTpIqP//SabQid+
 xxLgzhJCiEL/faPlJUOiWBK46jMDFKb3e8wiXTjyTCx+JrQMeypeMwy9IMMfsOxoMvLJswTgYIL
 xtQ0rgUQWn4Kn/KlvVw==
X-Proofpoint-GUID: H25Jfel8QtXxdktSjDI1K2ySGkdsKd21
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE5MDAzMyBTYWx0ZWRfX/8KfxgC7pgJ0
 skyhpP3LK2KcK7h67dT3iglX45sYOord0kO5UVB28c72iB6V6Q0NB6xqLth2pYubLDsBhamGgAy
 A35vgtoseRZ///7eAQrQykAc744ivLo=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-19_02,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 phishscore=0 priorityscore=1501 suspectscore=0
 bulkscore=0 adultscore=0 impostorscore=0 lowpriorityscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611190033
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

A DP HPD IRQ reports a sink-side event and does not imply a Type-C
routing change. Reprogramming the retimer for every IRQ can reset or
disturb its datapath while link training or video transmission is in
progress, causing intermittent DisplayPort link failures.

Cache the successfully programmed DP retimer mode, HPD level, and
orientation. When an IRQ arrives with the same state, leave the retimer
untouched while continuing to notify DRM so MST sink IRQ handling is
preserved. Invalidate the cache on non-DP modes and after a failed retimer
update so later DP transitions are always configured.

Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
---
 drivers/soc/qcom/pmic_glink_altmode.c | 38 ++++++++++++++++++++++++++++++++++-
 1 file changed, 37 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/qcom/pmic_glink_altmode.c b/drivers/soc/qcom/pmic_glink_altmode.c
index e903d4910e9c..5ae554dc01d9 100644
--- a/drivers/soc/qcom/pmic_glink_altmode.c
+++ b/drivers/soc/qcom/pmic_glink_altmode.c
@@ -121,6 +121,12 @@ struct pmic_glink_altmode_port {
 	u8 hpd_state;
 	u8 hpd_irq;
 	u8 mux_ctrl;
+
+	/* Last DP state successfully programmed into the retimer. */
+	bool retimer_dp_valid;
+	u8 retimer_dp_mode;
+	bool retimer_dp_hpd_state;
+	enum typec_orientation retimer_dp_orientation;
 };
 
 #define work_to_altmode(w) container_of((w), struct pmic_glink_altmode, enable_work)
@@ -180,6 +186,7 @@ static void pmic_glink_altmode_enable_dp(struct pmic_glink_altmode *altmode,
 					 bool hpd_irq)
 {
 	struct typec_displayport_data dp_data = {};
+	bool retimer_state_unchanged;
 	int ret;
 
 	dp_data.status = DP_STATUS_ENABLED;
@@ -200,10 +207,31 @@ static void pmic_glink_altmode_enable_dp(struct pmic_glink_altmode *altmode,
 	port->retimer_state.alt = &port->dp_alt;
 	port->retimer_state.data = &dp_data;
 	port->retimer_state.mode = TYPEC_MODAL_STATE(mode);
+	retimer_state_unchanged = port->retimer_dp_valid &&
+		port->retimer_dp_mode == mode &&
+		port->retimer_dp_hpd_state == hpd_state &&
+		port->retimer_dp_orientation == port->orientation;
+
+	/*
+	 * An HPD IRQ is a sink-side DP interrupt, not a Type-C routing change.
+	 * Avoid rewriting an already configured retimer while DP link training or
+	 * video transmission is in progress. The DRM HPD IRQ notification below
+	 * is deliberately still delivered.
+	 */
+	if (hpd_irq && retimer_state_unchanged)
+		return;
 
 	ret = typec_retimer_set(port->typec_retimer, &port->retimer_state);
-	if (ret)
+	if (ret) {
+		/* A failed write may have left the retimer only partly configured. */
+		port->retimer_dp_valid = false;
 		dev_err(altmode->dev, "failed to setup retimer to DP: %d\n", ret);
+	} else {
+		port->retimer_dp_valid = true;
+		port->retimer_dp_mode = mode;
+		port->retimer_dp_hpd_state = hpd_state;
+		port->retimer_dp_orientation = port->orientation;
+	}
 }
 
 static void pmic_glink_altmode_enable_tbt(struct pmic_glink_altmode *altmode,
@@ -214,6 +242,8 @@ static void pmic_glink_altmode_enable_tbt(struct pmic_glink_altmode *altmode,
 	u32 cable_speed;
 	int ret;
 
+	port->retimer_dp_valid = false;
+
 	/* Device Discover Mode VDO */
 	tbt_data.device_mode = TBT_MODE;
 	tbt_data.device_mode |= TBT_SET_ADAPTER(TBT_ADAPTER_TBT3);
@@ -271,6 +301,8 @@ static void pmic_glink_altmode_enable_usb4(struct pmic_glink_altmode *altmode,
 	struct enter_usb_data data = {};
 	int ret;
 
+	port->retimer_dp_valid = false;
+
 	data.eudo = FIELD_PREP(EUDO_USB_MODE_MASK, EUDO_USB_MODE_USB4);
 
 	if (tbt->usb_speed == 0) {
@@ -307,6 +339,8 @@ static void pmic_glink_altmode_enable_usb(struct pmic_glink_altmode *altmode,
 {
 	int ret;
 
+	port->retimer_dp_valid = false;
+
 	port->state.alt = NULL;
 	port->state.data = NULL;
 	port->state.mode = TYPEC_STATE_USB;
@@ -329,6 +363,8 @@ static void pmic_glink_altmode_safe(struct pmic_glink_altmode *altmode,
 {
 	int ret;
 
+	port->retimer_dp_valid = false;
+
 	port->state.alt = NULL;
 	port->state.data = NULL;
 	port->state.mode = TYPEC_STATE_SAFE;

-- 
2.43.0

