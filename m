Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF611C79FAD
	for <dri-devel@archiver.kernel.org>; Wed,  9 Sep 2026 09:18:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 34B5F10F044;
	Wed,  9 Sep 2026 09:18:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="lqg5tL40";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kfhHAihb";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 38DA010F046
 for <dri-devel@lists.freedesktop.org>; Wed,  9 Sep 2026 09:18:29 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6896BLcn1274463
 for <dri-devel@lists.freedesktop.org>; Wed, 9 Sep 2026 09:18:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 4tTCnaPUXZPu+u+JFAUI2y1je+qTRzz+PfxElcpWic8=; b=lqg5tL40txC/Nobn
 gCWxF8hRx8Xb0YbEHSOoOMxpknm5kSJAdUL0Xy4CwRn5PXKmZpzbSwne/dYEYviV
 q40zad8lV008uaQ0Ki50CHqmMAO3q6ABB976fJ7lSwiSIX7TnBkSqyqaTC998QNR
 KVXoajZ576ZZXraSR8UL7+Q+AFaFTWfuMBO/6+DG65IMUQiiR4KFu7RnmP7fbKw0
 GjvUuQlJk4aoh0d9xXoz2+Of/yKH3OCHbiCtdOeCzTGzp51IuBATViO/FKAk0yxo
 F+ZNu3/TOsD9DVCMrN/yuVNn2PcDttfOxkjKiWdcmD1UusJE2WYrCxyy/j+v/s56
 w2oCVg==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gjqdw3atx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 09 Sep 2026 09:18:28 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-930a312222dso55787485a.2
 for <dri-devel@lists.freedesktop.org>; Wed, 09 Sep 2026 02:18:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788945508; x=1789550308;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=4tTCnaPUXZPu+u+JFAUI2y1je+qTRzz+PfxElcpWic8=;
 b=kfhHAihbSpT/uill3ifRWB6O3HiOJ/uSAHbFVtezERPBWGR4qzcsaIeOiVa0afstf5
 AHawfy/2MzPT9gY1MxP1kisbPVlr/WdtkBcy2mf7F0JrDl+Bi1qyz+ABiPd5L2ZpLrUw
 fLG/dKz9ijSIjoamnDPG9YAl4Bdmxqkhf1TQwAwN2o/k9tHYAw6izfPyY1CFSFCk+COG
 O4yJVRaDuROEN4zHsncL1El8kWr3XekzIj9Vqxd0TSWMcaowaW76cRRCYA3gdjiuSKb2
 hhCpyyQV3xNWKw7yisDi2RTKVNl3u31gVjWD/m6i1cCpIcA5g+ro1tfr+FCvew6m76qj
 dduw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788945508; x=1789550308;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=4tTCnaPUXZPu+u+JFAUI2y1je+qTRzz+PfxElcpWic8=;
 b=sNAZ/zaGuESk0eLYY9cpy6SnPFoCe01MfCjpM98+90JNzW0BT1t1x+lAHlNh5cZHBZ
 LTehpL+JXG/gMxBYDmvhWYzffH6rK0fuOxB3ILLgYdQzUny8tq8HpRGh5a68590KONuF
 wXDfhbDxjpIgOfQ66KmQJg+HJliozhOs2tHTbEDrscWfzKOVOKgHNtTBA40+tpNT/VYq
 Ysa59xW0APMvRrLPVVhbwRn//SBq5U8Lh95RBa3wNltEV72lieqeOPqCOY8WztQsZ9ry
 8kKdEnB5zrKfHJr0Oxe77Lu+8w7INcLijlgNaqHRtw9gJamt/26BPzD1MWRwDCt6l3Dx
 EJwA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzsEAJtjgjg5X4TQ11HaiQRHiDloLUryUSfEfgdfcEB+EXSfpAsBtsNM+OSjurYilI+/wsbo6hE4CA=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lyMCOiupDyuqaQ2obir8D96E72J938xIMewpBzFyT6xvrlhPwE
 m5aMsx7fgTszpWxz0iXyeIEYPVi4GPrr8rbg6VX+s3RcMjLV4Z/agE2xtDUMlehzwR8FnKtPsW8
 3JMqpwPcOQT2+gKL8vdw5eTVOr3JjAjaJcERY+kr+pi6lC86RSZ+n1isSR+DJAtvnrn2Bd00=
X-Gm-Gg: AYBFou2XiOZUKZx59oDsKdOSBYlrLFho7Az49N8pIqTnp6PaVb3U+BTTs4QEs+REnH1
 aVEeuEdcTk7gzOm4awyvW2ZFB+Kt1jo9+/4FnaS+ZF42s15E1xM5+4dDRMMYX+ZUQrwxMBKZCoF
 jR2jsJPGSyeuLu5qMQaxROojIljburkPUgWpZ+mK9/IM51C7Yj1GKiclVwv0frhb05iwEPX7W6I
 ez8JnKHB+2GPcEgiswS/O+vJ9e1x5xpZaWFGhmA4vOPybuJ/9E0BFBxMxVLdosesd4dSJjkfgS5
 zXXoo9SMTuXV09fio0IGCbqh1sGs3MgIjhPKwyncdsFedZLXKKYCOxamg7qe6QCTrglKpmY446N
 oWloqB3TFvcAjnToungldhg==
X-Received: by 2002:a05:620a:1a06:b0:934:95d9:85fe with SMTP id
 af79cd13be357-9399180ba67mr2231678885a.3.1788945502725; 
 Wed, 09 Sep 2026 02:18:22 -0700 (PDT)
X-Received: by 2002:a05:620a:1a06:b0:934:95d9:85fe with SMTP id
 af79cd13be357-9399180ba67mr2231675485a.3.1788945502185; 
 Wed, 09 Sep 2026 02:18:22 -0700 (PDT)
Received: from [192.168.202.12] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c261e24a9e0sm680491466b.4.2026.09.09.02.18.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 09 Sep 2026 02:18:21 -0700 (PDT)
Message-ID: <9db74716-b0f7-4560-a5ed-9ecaca6a31b8@oss.qualcomm.com>
Date: Wed, 9 Sep 2026 11:18:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] backlight: qcom-wled: Fix unbalanced OVP IRQ enable at
 probe
To: david@ixit.cz, Lee Jones <lee@kernel.org>,
 Daniel Thompson <danielt@kernel.org>,
 Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>,
 Kiran Gunda <quic_kgunda@quicinc.com>,
 Marco Mattiolo <marco.mattiolo@hotmail.it>,
 =?UTF-8?B?QmFybmFiw6FzIEN6w6ltw6Fu?= <barnabas.czeman@mainlining.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 phone-devel@vger.kernel.org, stable@vger.kernel.org
References: <20260908-qcom-wled-backlight-v1-1-c4dd4eabda07@ixit.cz>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260908-qcom-wled-backlight-v1-1-c4dd4eabda07@ixit.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: S5RW592J2PY0zp8kYgdyYNL9x9Lv8D3B
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA5MDEwMyBTYWx0ZWRfX4EEmP6DGCu4Z
 lPtbf4YvHxgV9IoeFAzmkObvauDEXXDiVZcTdbOLCl+O5S3gcOcMVF3coVucuupXS94ZQhu4KzA
 vMcSLQdQ5KtwL6jJ/3kcmJT3W9+SoOo=
X-Proofpoint-GUID: S5RW592J2PY0zp8kYgdyYNL9x9Lv8D3B
X-Authority-Analysis: v=2.4 cv=Bo2tB4X5 c=1 sm=1 tr=0 ts=6aa12464 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=FSV59ufblPRWrHBwF98A:9 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA5MDEwMyBTYWx0ZWRfX4KtoTM9bm1l5
 pq56shb46xTQ8rrz+bueP2bFOiqtK6uQaE/Zp2ZMZ636eR5ZZn7+dd3EqPtaqj05z9UUuZKcC27
 XzjumSZfyYEBN9Sb8QVQdWP5I0WE1chlBVcS5NqUqnnTQ4A2iRDgo2x6dVPBStGcg1A3uKbuQx3
 ZKRTt+rj0qiXjA7IEZzed0zsHBaLovEYGDrDPY6sPDEN6PSv7AqeFBlV96D8cGXGnbxigAcHrDj
 s/UC+nzFpckpSwdIKS2bBNx0ymah/b/3kwCnYrH9cEuF3bNymBXEaMNdRxXLFslse2V1vQQv67b
 jABoZNwTfsQTaIxmsbnj3HhN4YVN+Bx0Mrtb7N050OlhvqFz5h70ko7JwgxAZPwLvvOhXHkatRo
 BaUqPYT2SkISqUxY9eFR1hUrIq5Wm1NWcFNQvjGhhK2PW3t4g19/sYitmZZ7auh1o2nrTYgA3mR
 oQwPkouTWvd8nPqmzQQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-08_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 bulkscore=0 impostorscore=0 adultscore=0
 malwarescore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609090103
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

On 9/8/26 10:53 PM, David Heidelberg via B4 Relay wrote:
> From: David Heidelberg <david@ixit.cz>
> 
> wled_configure_ovp_irq() derives the initial state of the OVP interrupt
> from the hardware:

[...]

> +	val = WLED_DEFAULT_BRIGHTNESS;
> +	of_property_read_u32(pdev->dev.of_node, "default-brightness", &val);
> +
> +	/*
> +	 * The module may already be enabled, either by a bootloader that left
> +	 * the backlight lit or by the setup above. Record that, so that the
> +	 * first brightness update does not enable an already enabled module,
> +	 * and so that the OVP irq is armed from probe rather than from that
> +	 * first update.
> +	 */
> +	rc = regmap_read(wled->regmap, wled->ctrl_addr + WLED3_CTRL_REG_MOD_EN,
> +			 &mod_en);
> +	if (rc < 0)
> +		return rc;
> +
> +	if (mod_en & WLED3_CTRL_REG_MOD_EN_MASK)
> +		wled->brightness = val;

This won't work for WLED5, you can implement backlight_ops.get_brightness()
and take advantage of having that function pointer

Otherwise I believe what this patch is good

Konrad
