Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF229F3ED4A
	for <dri-devel@archiver.kernel.org>; Sun, 12 Apr 2026 00:56:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 30B1A10E270;
	Sun, 12 Apr 2026 00:56:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="M/dTcW4e";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="OO00t9XC";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DEB1F10E270
 for <dri-devel@lists.freedesktop.org>; Sun, 12 Apr 2026 00:56:05 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63BNtQ7t2924362
 for <dri-devel@lists.freedesktop.org>; Sun, 12 Apr 2026 00:56:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 TJuL2zAsm/mRJ/D1VYU3rw82pVVk6vC6Tovx7zEwBXA=; b=M/dTcW4eqMV9UT5J
 neJpe+CIbzgS6vWRohc8c3boDooB6Swyb2uCUFaoaDlPgN+f0NvNLBICPgxziU5u
 eINzJorwj1P8C+l/jdj+G1+qJV1dJ0Rv/zTCscUBcGXKQTKRL3kAGIk2LmqljzLO
 d0izi5qCx/zSvFlLkVHRrVQxfuyCPwt6RVHDqEUxrEsQL+2ympsqaBSoG3u7iixf
 WpNgAgaras8qehSb2J9mUUv0n304Rzh/5t6k1RTTHMSYrae8Kbvcvs692WO88xdc
 iNOKF55F/6oLtTkEjQLG1vLIha7Of+V7+l2KtqWAvnUd/c7UnGD6/lFrajC1iE7e
 wakOZA==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dfevthkrd-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sun, 12 Apr 2026 00:56:04 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-35d9278587bso3163683a91.2
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Apr 2026 17:56:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775955364; x=1776560164;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=TJuL2zAsm/mRJ/D1VYU3rw82pVVk6vC6Tovx7zEwBXA=;
 b=OO00t9XC38APNKIhD+RBSIw+c97mZaZbC/rQyb3aGVkQeqPEJW5vx7nGat9of9KyQI
 qyawIMyHO3sky7ps9wMj0CgcihFzPBkmtg0kNBgqgQrqSvUWTEDAKW4HWpseucTOgfsx
 uO6XxVXe59C5p6qbThLr1gwixoupkaEuQTe7SQ85WAtTrl1HoI627ORDlvuSSr6qesqQ
 F9uz6+TgOVRxf17nlryq/ufle36tonesGhpuwV91IZSw+pTnocgpgg06W/Z7qn1n5Ppe
 9BD5h+SwX5cAitbWOfWBVYKDp83Tb/HxepmWJ4365mHLtLMEdzBEo2O5l2Wp8jluyEzI
 scOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775955364; x=1776560164;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TJuL2zAsm/mRJ/D1VYU3rw82pVVk6vC6Tovx7zEwBXA=;
 b=QwhKXD3v5n70/ymePOgTkEA7V+gj4fmCUjRCZkZxv0smqEmKzu9cMBoDIPmEOOyxmD
 d8E16j5EPV5uqowCcvj18+fRJ9YdTxAIlqL79GiFs0F9C1XvShoUrE17wjdOXnUTWN8w
 I9eszfBinr2qA7yD/aNBHwZU0CxnsdRFVLJt/Ab7fAzpIExInp7CrZxd7qUWZVINku57
 MD3baexZedx3xdpXc4u1uzDG5vjE8S+dOh6yLcj3XGe0cQHSVgquDAl4JwvIEFkgndKf
 87F87f2Kfzt0iOaK/9tXBfIGTKui3KpT+mmXOQ8W/kRHaT1G7DEmfi07HzOruSugFxuy
 K9Gw==
X-Gm-Message-State: AOJu0YxLixQ6XMd7PbrmCyoA1Bb8cz+qTj9pD9ZJmehFBa4qrS0cE1jo
 dNIrzh2cvLuJ7YRRBACjtvG0fvEd4rV3PTEmJ5IbXMKI+n5Ae4KlpAupGsCeRcsWkvVW+NOHhpy
 npM8MXi5If7vr3PneDbzuMp0pFaN5MJdMkGGb7MVfWMCDOpEl7jcdUYt/DDNHI3BlvMvKKEM=
X-Gm-Gg: AeBDievINxQ6KrJNg7DHiV57n0cjn98WpPd0CpTu0ljWv/1ZpnOtC43DQQWmywmakN3
 lDjWxbKQrvcUi6rqYk4QQ23hVJznrGQy4pdNUZbcLrO5XVg7GK6z2e9fwCyS8KHHEYmWHLTg01H
 2DX8OdZq++/1Iziv4Qb+dYzV9pMG6vCBeqQMgXi8ZdIcXpRUI3thx3VWOtABcVckLrrRa0C/RIN
 GYAgJn8Dn/9Vn7rkXGd+axNOfmvr1jwnVswPOFjC+2+8/5QYP+CLqRgmYURdM3LmrtZVpOzgWs4
 FGOhsbt/0gFGnnua7XSsSHVjysKiTyn1mlTeR4NozmI58JqzmskfydsBs0os13mpPoov7iF9CtT
 UZpAS0qjUibBcqOPxtQMcnoqiMiRI8B/v9RzGuFLH8lKleVNetFXEwpGvtnMg0+ihBiZxKYBLrj
 aRMW1/L3z6RQ==
X-Received: by 2002:a17:90b:538c:b0:35b:9896:cbcd with SMTP id
 98e67ed59e1d1-35e42854dfemr8109835a91.27.1775955363643; 
 Sat, 11 Apr 2026 17:56:03 -0700 (PDT)
X-Received: by 2002:a17:90b:538c:b0:35b:9896:cbcd with SMTP id
 98e67ed59e1d1-35e42854dfemr8109804a91.27.1775955363114; 
 Sat, 11 Apr 2026 17:56:03 -0700 (PDT)
Received: from [10.133.33.83] (tpe-colo-wan-fw-bordernet.qualcomm.com.
 [103.229.16.4]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35e42e8fc1asm3241796a91.5.2026.04.11.17.55.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 11 Apr 2026 17:56:02 -0700 (PDT)
Message-ID: <d62614ae-53dd-4925-b185-6834dc8a63ac@oss.qualcomm.com>
Date: Sun, 12 Apr 2026 08:55:55 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 12/21] drm/panel: jadard-jd9365da-h3: support variable
 DSI configuration
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Cong Yang <yangcong5@huaqin.corp-partner.google.com>,
 Ondrej Jirman <megi@xff.cz>, Javier Martinez Canillas <javierm@redhat.com>,
 Jagan Teki <jagan@edgeble.ai>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Linus Walleij <linusw@kernel.org>,
 Bartosz Golaszewski <brgl@kernel.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
 Riccardo Mereu <r.mereu@arduino.cc>
References: <20260411-waveshare-dsi-touch-v2-0-75cdbeac5156@oss.qualcomm.com>
 <20260411-waveshare-dsi-touch-v2-12-75cdbeac5156@oss.qualcomm.com>
Content-Language: en-US
From: Jie Gan <jie.gan@oss.qualcomm.com>
In-Reply-To: <20260411-waveshare-dsi-touch-v2-12-75cdbeac5156@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=RYWgzVtv c=1 sm=1 tr=0 ts=69daeda4 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=jw4kvcsodkeSSt-x1xwA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-GUID: vDz87bZK2Lfk9Sbe1r7Lup4yaCkCaR5n
X-Proofpoint-ORIG-GUID: vDz87bZK2Lfk9Sbe1r7Lup4yaCkCaR5n
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEyMDAwNiBTYWx0ZWRfX5SIYdRylvdvW
 EdMw7u52/9ZQAlbMNIWBWGtMp8OF5jxrSZH820tqOuWgEOKiq2jOTEtiRBCH5va8AnkecReIsj3
 l3inJNVIukQpDbhgvTf+vv+F2MNyH9CsLQpQQLUufMUBRNwVXpxNyxX03S3H0DtOJVLf0oi4orz
 XZa6LfIc/B8oqPIrIriu1EX0sBJ6V4JdNpUrPHbYsyINJpEkgsLjvdyF2way0+XydMHiPRxZyRF
 bZsZZQYjXm8qtYqN1kIUGRm4n8HiAcojYOqMRaE2fayJlXlz/Powvb6dmBSZorscyrPgpuyNdFC
 y2k2xHPLSJUzwW0DYe+mHaCyuXQIepcPv6EUBcBdB7bk4DBV+uMNHpHOK2flUVwSmUL8CZ+ktUh
 Tp8uyhvLXbu3fBjE+BJyrKEvyWLi76dXBonK9L874IOYWL7Q9ry8/Q0KxfFRCIIjUMeuKxqYvWo
 eMFLyFS6GET+nCSBhQQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-11_07,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 spamscore=0 impostorscore=0 phishscore=0
 clxscore=1015 suspectscore=0 priorityscore=1501 adultscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604010000
 definitions=main-2604120006
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



On 4/11/2026 8:10 PM, Dmitry Baryshkov wrote:
> Several panels support attachment either using 4 DSI lanes or just 2. In
> some cases, this requires a different panel mode to fulfill clock
> requirements. Extend the driver to handle such cases by letting the
> panel description to omit lanes specification and parsing number of
> lanes from the DT.
> 
> Reviewed-by: Linus Walleij <linusw@kernel.org>
> Tested-by: Riccardo Mereu <r.mereu@arduino.cc>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---
>   drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c | 32 +++++++++++++++++-------
>   1 file changed, 23 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c b/drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c
> index 1884ad2404cd..5d9db2e1f28f 100644
> --- a/drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c
> +++ b/drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c
> @@ -10,6 +10,7 @@
>   
>   #include <drm/drm_mipi_dsi.h>
>   #include <drm/drm_modes.h>
> +#include <drm/drm_of.h>
>   #include <drm/drm_panel.h>
>   #include <drm/drm_print.h>
>   #include <drm/drm_probe_helper.h>
> @@ -23,7 +24,8 @@
>   struct jadard;
>   
>   struct jadard_panel_desc {
> -	const struct drm_display_mode mode;
> +	const struct drm_display_mode *mode_4ln;
> +	const struct drm_display_mode *mode_2ln;
>   	unsigned int lanes;
>   	enum mipi_dsi_pixel_format format;
>   	int (*init)(struct jadard *jadard);
> @@ -57,7 +59,10 @@ static void jadard_enable_standard_cmds(struct mipi_dsi_multi_context *dsi_ctx)
>   	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xe1, 0x93);
>   	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xe2, 0x65);
>   	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xe3, 0xf8);
> -	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x80, 0x03);
> +	if (dsi_ctx->dsi->lanes == 2)
> +		mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x80, 0x01);
> +	else
> +		mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x80, 0x03);
>   }
>   
>   static inline struct jadard *panel_to_jadard(struct drm_panel *panel)
> @@ -151,7 +156,10 @@ static int jadard_get_modes(struct drm_panel *panel,
>   {
>   	struct jadard *jadard = panel_to_jadard(panel);
>   
> -	return drm_connector_helper_get_modes_fixed(connector, &jadard->desc->mode);
> +	if (jadard->dsi->lanes == 2)

Worth to add a check here:
if (jadard->dsi->lanes == 2 && jadard->desc->mode_2ln)

Some pre-existing panel desc(e.g. radxa_display_8hd_ad002_desc) only set 
mode_4ln, leaving mode_2ln = NULL. So if such a panel attaches to a 
2-lane DSI host, the NULL pointer dereference causes a kernel oops.

Thanks,
Jie

> +		return drm_connector_helper_get_modes_fixed(connector, jadard->desc->mode_2ln);
> +	else
> +		return drm_connector_helper_get_modes_fixed(connector, jadard->desc->mode_4ln);
>   }
>   
>   static enum drm_panel_orientation jadard_panel_get_orientation(struct drm_panel *panel)
> @@ -354,7 +362,7 @@ static int radxa_display_8hd_ad002_init_cmds(struct jadard *jadard)
>   };
>   
>   static const struct jadard_panel_desc radxa_display_8hd_ad002_desc = {
> -	.mode = {
> +	.mode_4ln = &(const struct drm_display_mode) {
>   		.clock		= 70000,
>   
>   		.hdisplay	= 800,
> @@ -586,7 +594,7 @@ static int cz101b4001_init_cmds(struct jadard *jadard)
>   };
>   
>   static const struct jadard_panel_desc cz101b4001_desc = {
> -	.mode = {
> +	.mode_4ln = &(const struct drm_display_mode) {
>   		.clock		= 70000,
>   
>   		.hdisplay	= 800,
> @@ -819,7 +827,7 @@ static int kingdisplay_kd101ne3_init_cmds(struct jadard *jadard)
>   };
>   
>   static const struct jadard_panel_desc kingdisplay_kd101ne3_40ti_desc = {
> -	.mode = {
> +	.mode_4ln = &(const struct drm_display_mode) {
>   		.clock		= (800 + 24 + 24 + 24) * (1280 + 30 + 4 + 8) * 60 / 1000,
>   
>   		.hdisplay	= 800,
> @@ -1070,7 +1078,7 @@ static int melfas_lmfbx101117480_init_cmds(struct jadard *jadard)
>   };
>   
>   static const struct jadard_panel_desc melfas_lmfbx101117480_desc = {
> -	.mode = {
> +	.mode_4ln = &(const struct drm_display_mode) {
>   		.clock		= (800 + 24 + 24 + 24) * (1280 + 30 + 4 + 8) * 60 / 1000,
>   
>   		.hdisplay	= 800,
> @@ -1326,7 +1334,7 @@ static int anbernic_rgds_init_cmds(struct jadard *jadard)
>   };
>   
>   static const struct jadard_panel_desc anbernic_rgds_display_desc = {
> -	.mode = {
> +	.mode_4ln = &(const struct drm_display_mode) {
>   		.clock		= (640 + 260 + 220 + 260) * (480 + 10 + 2 + 16) * 60 / 1000,
>   
>   		.hdisplay	= 640,
> @@ -1562,7 +1570,7 @@ static int taiguan_xti05101_01a_init_cmds(struct jadard *jadard)
>   };
>   
>   static const struct jadard_panel_desc taiguan_xti05101_01a_desc = {
> -	.mode = {
> +	.mode_4ln = &(const struct drm_display_mode) {
>   		.clock		= (800 + 24 + 24 + 24) * (1280 + 30 + 4 + 8) * 60 / 1000,
>   
>   		.hdisplay	= 800,
> @@ -1614,6 +1622,12 @@ static int jadard_dsi_probe(struct mipi_dsi_device *dsi)
>   
>   	dsi->format = desc->format;
>   	dsi->lanes = desc->lanes;
> +	if (!dsi->lanes) {
> +		dsi->lanes = drm_of_get_data_lanes_count_remote(dsi->dev.of_node, 0, -1, 2, 4);
> +		if (dsi->lanes < 0)
> +			return dsi->lanes;
> +	}
> +	dev_dbg(&dsi->dev, "lanes: %d\n", dsi->lanes);
>   
>   	jadard->reset = devm_gpiod_get(dev, "reset", GPIOD_OUT_HIGH);
>   	if (IS_ERR(jadard->reset))
> 

