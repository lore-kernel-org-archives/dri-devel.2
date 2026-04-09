Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0BAD10FC456
	for <dri-devel@archiver.kernel.org>; Thu,  9 Apr 2026 00:49:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9BBBB10E705;
	Thu,  9 Apr 2026 00:49:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="H997VMoG";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kKtnjzU4";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E0DB010E705
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Apr 2026 00:49:56 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 638L1eVe2614568
 for <dri-devel@lists.freedesktop.org>; Thu, 9 Apr 2026 00:49:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 bqEE6rmLZOuTWDnBfLI0DnPCbDUB+b65JdryhdhG+uQ=; b=H997VMoGJtsBo9IP
 5hoqIg7GV92AcWKMb8ztxkKxeiK+7qXPwfWN/IcOtKTagUwXSixzQLjsquQ13ngp
 QTTKonO8bDJq8Ih0/tUiHEN0P+draBnmYPBhThZ35T2LINShFDimMI5Zx/0CYtDX
 lTeaizxr8uX6MR1wdKk31hsLkbXTvDWhRS3ptJJL9vtL2/XkRPSfEynVJbXddsfP
 0aMvMU8gO3Dzl1iuZQbWWZrNqtwj1FMLQXjtugwRdidjtjR7lXREY27ZzFFKi15v
 adVT1JkMUepaDUZptultXwq07GC6UfHemKx+ThlJWox2mR3GdDDPeTvFRDW+QmAb
 78ZIvA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ddt28st4m-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 09 Apr 2026 00:49:56 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-50d831e8083so16275451cf.3
 for <dri-devel@lists.freedesktop.org>; Wed, 08 Apr 2026 17:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775695795; x=1776300595;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=bqEE6rmLZOuTWDnBfLI0DnPCbDUB+b65JdryhdhG+uQ=;
 b=kKtnjzU4TKgfuch9Y8GmUjuiiYezi6tuHeutSoU9yMoWz6LLhodncR1E/sy387wtTH
 Al7Hm2WLHlWYjqHMy1jSHtMWGla/dBCDQttE+mW+gtA5cBLzyE/g614nuk2xb7ha4tWI
 pMqVe9lNm2BULxiL5YMkDKU/NhxHG/xONActpUwiT+ZYcNVTkGuhPJth2+oTYEE8rz4h
 04kXNkJhD1q7zfNX6xX1+tAHet0WbdZSFaRToyrzk+MgpJiu2HJwgkJCfVUgtNvLTqYZ
 1/FY+IjtXkyv7/D+t+q+d30GecDRw3msCyrhgDdh7j/m79TDygGaNktZEEYBFjSOzUzT
 n4Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775695795; x=1776300595;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bqEE6rmLZOuTWDnBfLI0DnPCbDUB+b65JdryhdhG+uQ=;
 b=JlE+vvLNzdIKoUBV56oOCrlJTtvnpBLkfhtLqvlal4Iq/Jd/GX4LssDYAbI4ocxuPS
 u28Xeem+PKtKl+PpYups7ukXmz1ljxFOB56sM2cxKH72brDFnh8y/k/p06sv2EaivMRZ
 6SgoAnaNl1MGrPrSZdiBXXsrGhZ6rP6IqP9/ZAOFrUFxVbXDeUgPXKWFrzRShZmRWiLA
 /tP98xN6A6oFcAwWWampVtVl1dxy+F/n2VHdyN4SkVzLVJrCm+6CYReoVJZjH7T9m9Wv
 6c7g8Yh8UvsGLUeqxHPhOXlWswQbIh9d6DkTqffbd9sKFG2AEQYCbIj+6rAnbAVuVA3m
 XwYg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUz2wepOG5CSwtFxqi0sbqEfVtBEV1PRjIrP23X+QiE+rV69Ul08AVVrQF/suwDRIV/MI4oDx/tz2w=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwyVLa8X346bwoqg4C2ydC6JlroYC7B8mj7c3q4UKv2uI/ERe3C
 BfI4PANh734uQ4MfdEG8888cJ6J6UyZznFghw9dwkIJ15DppFriYTgEYZcadQnEsHPgjBJYETGb
 A+4tUQBJqZj2+SV6Je2Iq9yfk1KiWK892/4TJ1pARKoKMQkdXzTegfndQU26yAQ3Y96hydOo=
X-Gm-Gg: AeBDies+xhvqy3zB5Z0oeviW1T8GTRWrFYKHrZZMbxMZggHgZINrJw8B7w6OhDKL+oP
 RwGQR/6u04XGLLAZC7VVQyEEdvFcA0t7Eis2mlO9deZRmzMywsM+b9f91acn8o98LkzF2eIV4w1
 VzmZIYYzEbf9Rx1SqLsdqwUbVk6fEjCa1ZoxIUK3xe7ct9CeSbFoLaby8IcRdyYTvtq+zmwd+bf
 rTM7mf/6zW771wmpCy2E0U/h5ia7YhY1ZH6E4pnfID20vpxLq4nhGQAiE7lQku90q/HreJNfRUf
 fWg3snLZgt6Dzn9LG5NMSok1+0v0u33gU5gRPpmcUTbC6/2dJR//JsS/tFnXkz/eTaeXZlSRfDj
 T7xMCC6TNViiR/GntjvyiuuYIloAe4YzRwrWbOMqQCo7zferYUOPLJno+4BGgl35IJb+DriVhvA
 bj0JNFQjdvNKnmWP8+I+2HO0CL3K6ZWIc0sa4=
X-Received: by 2002:a05:622a:11c4:b0:50b:4946:2776 with SMTP id
 d75a77b69052e-50d62bb43c2mr334343301cf.22.1775695795200; 
 Wed, 08 Apr 2026 17:49:55 -0700 (PDT)
X-Received: by 2002:a05:622a:11c4:b0:50b:4946:2776 with SMTP id
 d75a77b69052e-50d62bb43c2mr334342991cf.22.1775695794781; 
 Wed, 08 Apr 2026 17:49:54 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a2c6cd34f0sm5150705e87.76.2026.04.08.17.49.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Apr 2026 17:49:53 -0700 (PDT)
Date: Thu, 9 Apr 2026 03:49:50 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Linus Walleij <linusw@kernel.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
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
 Mark Brown <broonie@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: Re: [PATCH 14/19] drm/panel: jadard-jd9365da-h3: support Waveshare
 DSI panels
Message-ID: <z3obsnbmdvvlzs3cxm57osbax4ivg2zq2zk6xgp37n4hni7y6i@smwn362nhn6a>
References: <20260401-waveshare-dsi-touch-v1-0-5e9119b5a014@oss.qualcomm.com>
 <20260401-waveshare-dsi-touch-v1-14-5e9119b5a014@oss.qualcomm.com>
 <CAD++jL=jUd4sQ1bhwcBRYpFFApP6vdJw2BoQwxoWShUKdEb9oA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAD++jL=jUd4sQ1bhwcBRYpFFApP6vdJw2BoQwxoWShUKdEb9oA@mail.gmail.com>
X-Proofpoint-ORIG-GUID: 26d66T402x6RABIu7Tx-S7cHyDQncrxC
X-Authority-Analysis: v=2.4 cv=fIIJG5ae c=1 sm=1 tr=0 ts=69d6f7b4 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=EEnmvuoukryqth22VUsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA5MDAwNCBTYWx0ZWRfX70UiXA1XtXLe
 bJ1wLnG0cyy9EFTNQwSI/zV1pI83lO6/wvqty5wWt+WHzgIiQSTT4FIkzNMO8vrAuYjwfm5i0KH
 qd70C6TyU1akqgnz7GFSuGh7vMe/+PoiIb/Q0dK++t2fVQJJseHgNxSTYTpiwIlt/+z08NO5EVs
 IOMtSNlsAjftXNvqwo6QOCMcuo8HY8TGRR6gll0gPFkXUCAvihkZ2QHSlRxHbChq4RCy9WfUJRH
 yWEgPUSXQX4iNSYBfywe3K+gjjiFKW9o3jjb5zmmUOGzrEK4+rIM4uLIMXh+KpdgOzsfhGorsd3
 4aSKvc15YbxBZHgcSF+RxDTNwLrja/4vHczNWibvFrDhxZDrS8ArZXa0bnjH4ImZc6/oXNkNz0M
 Imio9WDM/lCh/lWg8TeeEwjtk7gn85tHWcX+lWBOha4PJk3YwYV5DeLIJZ4Tg0xMcjskjdvJN8O
 6RvlfUPHj3r4FVo48lA==
X-Proofpoint-GUID: 26d66T402x6RABIu7Tx-S7cHyDQncrxC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-08_07,2026-04-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 impostorscore=0 clxscore=1015 adultscore=0
 bulkscore=0 malwarescore=0 phishscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604090004
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

On Wed, Apr 08, 2026 at 10:24:17AM +0200, Linus Walleij wrote:
> Hi Dmitry,
> 
> thanks for your patch!
> 
> On Wed, Apr 1, 2026 at 9:27 AM Dmitry Baryshkov
> <dmitry.baryshkov@oss.qualcomm.com> wrote:
> 
> > Add configuration for Waveshare DSI panels using JD9365 controller.
> >
> > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> 
> Some more words with details on all the panels added perhaps?

:D

> 
> > -       desc = of_device_get_match_data(dev);
> > +       jd9365da_switch_page(&dsi_ctx, 0x01);
> > +       mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x00, 0x00);
> > +       mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x01, 0x41);
> 
> Predictably I'm not very happy with all the unexplained magic and nonestisting
> defines used here. Do you have some info/defines?

No, unfortunately.

> 
> But there is also one more thing, this looks like a big "jam table"
> with just register+value tuples, so construct something like:
> 
> struct jadard_jam_tbl_entry {
>         u8 reg;
>         u8 val;
> };
> 
> static const struct jadard_jam_tbl_entry jd_3_4_c_init_jam[] = {
>         {0x00, 0x00}, {0x01, 0x41}, ...};
> 
> (Ideas taken from drivers/net/dsa/realtek/rtl8366rb.c, take a look
> for code and all, you get the picture.)

Few months ago the code was moved exactly in the opposite direction. We
added all _multi() functions and made shure that the code is as
efficient as the register tables. On the other hand, having it as a code
allows better control. E.g. handling 2/4 lane case would require extra
hacks to the register tables, while the code handles that without extra
hacks and without loosing effectiveness.

> 
> Yours,
> Linus Walleij

-- 
With best wishes
Dmitry
