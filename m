Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 479D3C982E1
	for <dri-devel@archiver.kernel.org>; Mon, 21 Sep 2026 09:29:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7F3AC10E120;
	Mon, 21 Sep 2026 09:29:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="i8XfHTSe";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="H9GD48t+";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AEE9C10E677
 for <dri-devel@lists.freedesktop.org>; Mon, 21 Sep 2026 09:29:08 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68L8afgf4146854
 for <dri-devel@lists.freedesktop.org>; Mon, 21 Sep 2026 09:29:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 sp8pjoffAdrQ2Yno0i8Ngqu6RPdDWIsL95RhSPJ18pQ=; b=i8XfHTSeay8DT1Fh
 4WrZG5wurO+Dfpp+YDGEtXm1ZVk4Yk9CN2MtkbRrnes6lByDq3qyDNiMofF9HCl3
 t9w7AM4CSKL9jPqVeeUs4T1Y/uZzcQnjrLFfqaebRaJE4dnH58uEkH0EyGMYIOfJ
 t546zULee1PNU7JJgbu/2nSUpP3boSRJFFLrn0zeL6UTgJGaFtgBY+6kPteNUAnO
 NneebAST39au2u+cJuczn6O+eSlpkw9F0Y0XvQ9/yxpcwtnbfWS7+pfdSsqn0Pt6
 moZ8sLALYa+sPX2pTJ8ero98BS48PzNqOYVBSfEmUXoRnTHc51MK1VVMtOeX0tSV
 D7rBew==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gu17gr7rr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 21 Sep 2026 09:29:07 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-939f8e7ff71so91971285a.3
 for <dri-devel@lists.freedesktop.org>; Mon, 21 Sep 2026 02:29:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789982947; x=1790587747;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=sp8pjoffAdrQ2Yno0i8Ngqu6RPdDWIsL95RhSPJ18pQ=;
 b=H9GD48t+eX4NkdRUgbfQWCUWfKfYrkwwSESxxGs/xqg9dJIFQLEOWXUA0XtnAO5rX3
 v2MsbHBn3eTmZEtA3/HaMfsDnsCaV4Wmz6+hqHmLCT4McNNJtA3FgMUrdZO9kr6/7zL1
 JwualXc0YjrWO5Mcsl8hEOI5Yw+vHznf/VYTd9C0X0qUPoMvruxiNRyr+cVAOc8Dl190
 a3DEo7s1EAK2HuL6IDfJYH9IpBsv/AqGGi/dgUXZ/V3StmWid0xFPPDS2hMqIuJnPNPM
 mGZwiuAzHIQ4M+0nt3r89/0meGsZYM6VSEfqW64ARSENKa3yKi2xrF7WcA4ZJghoYGN+
 oNtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789982947; x=1790587747;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=sp8pjoffAdrQ2Yno0i8Ngqu6RPdDWIsL95RhSPJ18pQ=;
 b=dyhe1N8clqMTA3OwVJoDAqpLpouIsJ5BDUlsr+68EPxh/9CYrOnZLslO+DGOPcS0r/
 gNO9ovhZ/RFTLguVifREcHI7HSgUPDky/bFSifGhymAZPQns4ck7zNFM6Ba9dF3V/EKk
 XDPtMSREa/3r1BQ/MntVTYaItP9HVy437I8snAGhRMC8avWmD+KvvmOtxzdqkxVhKMKj
 DtYI6pDtMcb3eU0tj5yd9f6rFKSK9JOJR0iDOtJmhyRzrvAaUF5Fe7OlFsSjRg4J6os3
 rKZGwam+0ohVxCemDjO3n0+YaMPSZjuk5cvFLx2lekyk2/7HXsQQ58vfUrruyeunrDGo
 tuDQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzp0E1kR7w4KMb4iqtwmXuzvzZKKLylboKiuY4X/k7eW7ApjiJO8r429yAsznzhBkvGlqS08qqnsVU=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nnGShLXUDwXJq0Xa989dw9ExfOQL3DbdUe2neP5f/S2NtKsY/e
 45oBpr/o/y4TdEHsFm6F6Mlq5sWsyhFsYULai2kbSr1SAHO0iy9+IkR+YVpOyUtPyegGhl4R6tq
 /p6ZOXmGvnFjM10xhgZvyFGXz4ILhefA5SFhiy8hNWHZeW7T17lzO/2zC20j/umuodKx1UNo=
X-Gm-Gg: AYBFou3eGkBfUOTlIUyTTg+/5JmmnC/130PgfJJZNwKPq+OMSqrcdrfmndPREdUq97u
 SfOezrNRyhYb+eAnOvthEQHY5yMdgRn6BmO+BoAy/UH3XbIUlC5IbsbtVrsycwdutxu4L6Eo2Zv
 9xEdgEQT9SCIjzx9Bnwb9f8r3k1ilYVRsh2Gq8IdBJRx7yqzBSwzh5fWeToZxL5OqQ7V5G+9VxR
 Lanjh47uAklagmm2XGeAOjR8OwzQRSr9Z3l8HAY7gdhLsIVUBZ2sXxhQIEGhgPwqnt67ieEGFi+
 WzB+uqM/2dq5r4h58K5bZAzek3J1m8iUht0N3VmxuGFKcZXCEldJOCYNWMdN9oAXwMHJLjiGwOa
 paustL7aVFPcEcUhF9zGu7Q==
X-Received: by 2002:a05:6214:76d:b0:90c:e7f4:8bfe with SMTP id
 6a1803df08f44-9129c780e3cmr115802066d6.2.1789982946590; 
 Mon, 21 Sep 2026 02:29:06 -0700 (PDT)
X-Received: by 2002:a05:6214:76d:b0:90c:e7f4:8bfe with SMTP id
 6a1803df08f44-9129c780e3cmr115801736d6.2.1789982946186; 
 Mon, 21 Sep 2026 02:29:06 -0700 (PDT)
Received: from [192.168.202.12] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6aa67e11071sm3867362a12.23.2026.09.21.02.29.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Sep 2026 02:29:05 -0700 (PDT)
Message-ID: <acef563c-8eb7-4c7d-8048-49e3b0545437@oss.qualcomm.com>
Date: Mon, 21 Sep 2026 11:29:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/4] backlight: qcom-wled: Fix WLED3 brightness
 register stride
To: david@ixit.cz, Lee Jones <lee@kernel.org>,
 Daniel Thompson <danielt@kernel.org>,
 Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>,
 Kiran Gunda <quic_kgunda@quicinc.com>,
 Marco Mattiolo <marco.mattiolo@hotmail.it>,
 =?UTF-8?B?QmFybmFiw6FzIEN6w6ltw6Fu?= <barnabas.czeman@mainlining.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 phone-devel@vger.kernel.org, Joel Selvaraj <foss@joelselvaraj.com>,
 stable@vger.kernel.org
References: <20260914-qcom-wled-backlight-v3-0-d69fe9843841@ixit.cz>
 <20260914-qcom-wled-backlight-v3-2-d69fe9843841@ixit.cz>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260914-qcom-wled-backlight-v3-2-d69fe9843841@ixit.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: f_hXT-B_RVuHM4LGCtwmptzvNIAY3p0b
X-Authority-Analysis: v=2.4 cv=IewSymqa c=1 sm=1 tr=0 ts=6ab0f8e3 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=VwQbUJbxAAAA:8 a=fY3HbpO4PgkFXDM8leYA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDEzNiBTYWx0ZWRfX7goRz/edDoFe
 rkIcsskyD9xfKSV9CoKkZmfB2Gt6+2hjXAQIRjw+SeCqMeTeMEJG4nVwYyZQB/w0vlrYsoN+EOA
 RN5HsLOSdYBVuZM0a9wz/BGR0UcKHL366byxVEl3dwI848KBM+XxEODsemLxj6skPVGcJ5zYW1S
 Iv11I22xXgELXRTMYBT45iV/MmdOHwnjDJ75ysJfiU+lsU62Ezh8LT8vn4bZVALSMMugOGgaHkO
 /JCXBkdAkZJicgqqJDQwB0/G0dxfoIQJypw5U2lxcZEAbiqZuNW9gz4SO+AwQOT1DHSwEnxG+mV
 A48/1pOAEbOOOjVBUMzKb0crcJG2zmlw8SNrUxdhrL+IETsQT8AaW8If8OZ9+nwB7SLAzkEVxIy
 klzWYGc/6eIMjpkUOhVo0JuFHCLEhlmVtl8wDpbOCjS2XaAVqoDtX18ViUqdG5tBY20asKObMWJ
 AJ94M7MswoLzHqaRNrg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDEzNiBTYWx0ZWRfX4eegH2+qd2j1
 h0Nx8L0zlKrRBYY82qUXqV/ZKr0EnvWJPAaUUSL96ULIdGcbqTy0iHarqRxO/plyzHMjRjKr5LJ
 3L51i5ijYFEKYvbgFMLvMW2Z8Hr9B9A=
X-Proofpoint-ORIG-GUID: f_hXT-B_RVuHM4LGCtwmptzvNIAY3p0b
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_03,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 lowpriorityscore=0 spamscore=0 phishscore=0 malwarescore=0 adultscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609210136
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

On 9/14/26 8:14 PM, David Heidelberg via B4 Relay wrote:
> From: David Heidelberg <david@ixit.cz>
> 
> WLED3 has a 16-bit brightness register pair per string, at 0x40 + 2*n,
> which is what the pm8941-wled driver wrote to:
> 
> 	rc = regmap_bulk_write(wled->regmap,
> 			wled->addr + WLED3_CTRL_REG_VAL_BASE + 2 * i,
> 			v, 2);
> 
> The restructuring for WLED3 turned that into WLED3_SINK_REG_BRIGHT(n),
> defined as 0x40 + n, so the two byte writes for consecutive strings
> overlap: string 1 overwrites the MSB of string 0 with its own LSB, and
> with the default three strings only string 1 ends up with the requested
> value.
> 
> Use the 2 byte stride.
> 
> Fixes: 775d2ffb4af6 ("backlight: qcom-wled: Restructure the driver for WLED3")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---
>  drivers/video/backlight/qcom-wled.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/video/backlight/qcom-wled.c b/drivers/video/backlight/qcom-wled.c
> index a76158a298335..e1962c2d90ed4 100644
> --- a/drivers/video/backlight/qcom-wled.c
> +++ b/drivers/video/backlight/qcom-wled.c
> @@ -54,17 +54,17 @@
>  #define WLED3_SINK_REG_SYNC				0x47
>  #define  WLED3_SINK_REG_SYNC_CLEAR			0x00
>  
>  #define WLED3_SINK_REG_CURR_SINK			0x4f
>  #define  WLED3_SINK_REG_CURR_SINK_MASK			GENMASK(7, 5)
>  #define  WLED3_SINK_REG_CURR_SINK_SHFT			5
>  
>  /* WLED3 specific per-'string' registers below */
> -#define WLED3_SINK_REG_BRIGHT(n)			(0x40 + n)
> +#define WLED3_SINK_REG_BRIGHT(n)			(0x40 + (n * 0x10))

You said 2 in the commit message and you set it to 2 in patch 4

Konrad
