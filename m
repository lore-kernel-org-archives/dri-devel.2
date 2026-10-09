Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AC8ACA5FED
	for <dri-devel@archiver.kernel.org>; Fri,  9 Oct 2026 08:34:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9A52510FF9C;
	Fri,  9 Oct 2026 08:34:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="G3JmpNuR";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="h5zGpJQ2";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0EA0710FF9C
 for <dri-devel@lists.freedesktop.org>; Fri,  9 Oct 2026 08:34:38 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6998KMDt1223197
 for <dri-devel@lists.freedesktop.org>; Fri, 9 Oct 2026 08:34:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=pKNoPzYs9svU6eazntWGtkQq
 4hl2TnKUIjurAm47tJA=; b=G3JmpNuRKq8VIslY+OgL6deVdaPG4ukkBvVnmJYO
 ePlZqQOBaIg7OaQgHr0rFOCWAnkM1tiBgsQRfSVqLtLG8mawsSz74HInpJL4Gsj8
 1T5V7KuYgH4ALnWjD3guijJhwqN4yXLN8+AA4keRSG2t6p0g3arVUSKhez0hCWxR
 eRqvCxI5AZwi/ADYQXmEStlVLy4gDiNnZTdSy9KvnhpJXW0V61vpJMF+31zx81xa
 Zarwiwhg0rfx6XsZw5ck4kF+3Qw339Q1kW6jbV3HmDDGDjExPeddDPYHPh6vlc44
 tojO+ISeb+xbMGARcO1zwCYImtm/IC2hEwNtVn9UqiRhug==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h6fxkam13-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 09 Oct 2026 08:34:37 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93cb6391e89so1220192585a.1
 for <dri-devel@lists.freedesktop.org>; Fri, 09 Oct 2026 01:34:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791534877; x=1792139677;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=pKNoPzYs9svU6eazntWGtkQq4hl2TnKUIjurAm47tJA=;
 b=h5zGpJQ2RM9eI+wdu+p+p3NVnYiHtNdJLxbWoGZlbBYwm8OoCvwsGDPlLZlweqtFlD
 tr7erdPvXhDT9pEfTl+kUVTRRxLqlYEOzSslSwKRY45VdK+ft0vXrkDMvNtNK9HvlTwr
 F8tdLntxRJ1y6Y24/tJBShJPTkZ9zWRE5/ML8BwB/JrgwAQcKwIAIbha+81mmwVJj6x9
 54BXB2cJuqsWgyVF1Mob1ePZIC+5kRdxHYmmsZlF9/Q6a+96S8RRlHCn1xg8wj31oGGZ
 cgVdIYPeVpL4Lf/wBJvU155Zg7Dq71R3FSgZqHFWUV8NNVOjxr7nzavEZ9gucs555wjh
 cRjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791534877; x=1792139677;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=pKNoPzYs9svU6eazntWGtkQq4hl2TnKUIjurAm47tJA=;
 b=mwD6sUVbYja6+1CATEPBwoir8sgFIzWQ4xvWiSHJCxoiDSWZJO2moDRKbDFwPvgc3I
 5HhvGFg1y5O0fjE/4DvnxENt0YSUEQBhPdGdt2NQ0PLIEOlIaRyAOJw8DLB2LslPS3Xh
 1VZ+yxA2hcIUATsltIk5vRPAPX0hQ4NO0iAFbgc+/RC+TYWps7o/hfOzgnFOpxZYWj74
 NpfDYNTaSu5snYiK4FSXIWH77DkU1yZkNEOhYcMQbHBQkUI9Ms3Q7HufdykrJYbCSu94
 16O+at2VqUZkFd10gtCaUmRoVRUbdSAAiFqt7iGJRstnuJgOWcZUUADPdzSM1l4L9c+3
 rpGg==
X-Forwarded-Encrypted: i=1;
 AKwUvBx1KR5uXs5Cq0HH3Vv5UT8dhSJgi7IZip+kvpan7FCkGQseX7Izm6r4RcB3U3rzUtvBKaBjdFRS4ew=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lbL6BGUHG1x3tz2NM1ZtdHwTWPtqTJNeHvSo4TWQCq7D9Pe+Uo
 3EqhkZJ4P9RfTD/cFR699Tl2qOkPv0NFQv2qneNam42sw5RFA4ywp0DpCbZRGzcFqLukX5qP5tS
 FHP6eMGaFXYdNkZQU67NmV4uM2XIku800fm/QFmXM0nfIfcV96Fnz24jy3vJja6+AXgZhTps=
X-Gm-Gg: AYBFou0jvDqnfTR0MiTdxXPWer3PwZTv9GI05LQYXdVni6pfCgduZZSNqpqo01HxAe7
 PBoVPQ34th+Nrms65jNE3GFermrMh83nmvo0avnw8HiwnTEvACM7LtFf+ZI1JDE6U7wpM2pWnjH
 ObcxEc6Jx8E14Hf3fHRSPovjgCKS3fS+2L2fG6cDTBfAkORAyjy1y2lGNZ9Znxm9ES+vQ+XY8p2
 73ecV2zTbmfRnPjtG6h0E9hwNsiCVP53MQKU33JLjxRq3wGe5EnB6jlM6eXzr+8MgCT3YCIyWyX
 u9Pmilyh+r/cD1LiwGqEd5bn0Hzy61UMx0xgFGwzGZ5G3Qk27IeXpVeOnMtOF301ySmwxL7yZy7
 gF9li1XQWDat5msfc1SufZdzuux29nOnlaH+8vO4RDSJ2ntTHZvlo1YMhePaWBgONcAIyKlzhq8
 dXO88Xnfd6y3ft
X-Received: by 2002:a05:620a:468a:b0:939:57ca:7e08 with SMTP id
 af79cd13be357-93ebd0e4190mr162078885a.2.1791534877291; 
 Fri, 09 Oct 2026 01:34:37 -0700 (PDT)
X-Received: by 2002:a05:620a:468a:b0:939:57ca:7e08 with SMTP id
 af79cd13be357-93ebd0e4190mr162075985a.2.1791534876796; 
 Fri, 09 Oct 2026 01:34:36 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3a9c3befd30sm4730841fa.3.2026.10.09.01.34.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Oct 2026 01:34:35 -0700 (PDT)
Date: Fri, 9 Oct 2026 11:34:33 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Balaji Kalkonda <balaji.kalkonda@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Kuogee Hsieh <quic_khsieh@quicinc.com>,
 Yongxing Mou <yongxing.mou@oss.qualcomm.com>,
 Yuanjie Yang <yuanjie.yang@oss.qualcomm.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>,
 Mahadevan P <mahadevan.p@oss.qualcomm.com>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/5] arm64: dts: qcom: kaanapali-mtp: Enable USB headset
 and Type-C accessory mode
Message-ID: <ytqzmngqzb2ear5ovqexrzcw63t7plac7hvsbh3ce32krt4mfd@e3yyzs6y5anq>
References: <20261005-kaanapali_dp-v1-0-6faeac3a6d59@oss.qualcomm.com>
 <20261005-kaanapali_dp-v1-4-6faeac3a6d59@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261005-kaanapali_dp-v1-4-6faeac3a6d59@oss.qualcomm.com>
X-Proofpoint-GUID: ovAHyoaeMO4x12009xD9-cUK9Hx7mrgl
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDAzMiBTYWx0ZWRfX/TvYog4ppsFU
 srRRNMg9IA0AMjaOfYqP77FR8wKdGTn0xpsvaghk9hc8y4at1VtV6EimptsM+LVg0cVkrFpARlX
 0hOmTAPYkPvyOl2WHq/5mPx7g7eqi/E=
X-Authority-Analysis: v=2.4 cv=Cs0q4X4D c=1 sm=1 tr=0 ts=6ac8a71e cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=bh13_d1_8jtD0fUh7gcA:9 a=CjuIK1q_8ugA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDAzMiBTYWx0ZWRfXylWOgKz+j3Dw
 lhm2T/DXX8hOg/mGs0kzNSBOef9tgQKKtBepAFrGccoFX4eabGYoc6CrKNJ+O6uE+W5Mwa+D0zY
 wNGm3K5TcSnoWIy2duQwN9dwJQgw/+Il9zFjLu6rMo7u/J+NYISSZ6mC34wxiC42GsBaUHMpITR
 eyW57FKGBlj55d1q+HlIU20gp+YgjhNcRk0TBye8hXTLzJ/akEg0bcfmwjRvCEpw4SDrPlejlCr
 dlE5CRZa69Yy/wUizDfIBxvJHtQhyG95AQSdsXVLvSJsaHdqBC2r8ZjXyT26sHh5+4x1si4PvdX
 n3N9UoTfS1YVBOg4wrOf1O9vA+2vu5cNhLKLbyu5dduJjcEGqg8+T5G7kLiPHc/YjYYfULdgB05
 pey9B6q1xVWe8BO7SH+XWuLv7/uazk7zmVJeDVIZxfVJCpj6ehUCq+Av1y/nuwbSfROCmvNVhFR
 vSUo39HhZAtSh3tPwBQ==
X-Proofpoint-ORIG-GUID: ovAHyoaeMO4x12009xD9-cUK9Hx7mrgl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-09_03,2026-10-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 bulkscore=0 clxscore=1015 adultscore=0
 priorityscore=1501 lowpriorityscore=0 impostorscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610020000
 definitions=main-2610090032
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

On Mon, Oct 05, 2026 at 12:54:29PM +0530, Balaji Kalkonda wrote:
> MTP does not have audio jack connected and relies on USB mux (WCD9395).
> Add necessary nodes for proper audio headset support along with USB
> Type-C accessory mode and orientation.
> 
> Signed-off-by: Balaji Kalkonda <balaji.kalkonda@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/kaanapali-mtp.dts | 51 ++++++++++++++++++++++++++++++
>  1 file changed, 51 insertions(+)
> 
> @@ -916,6 +926,42 @@ &gpu_zap_shader {
>  	firmware-name = "qcom/kaanapali/gen80200_zap.mbn";
>  };
>  
> +&i2c3 {

No clock-frequency?

> +	status = "okay";
> +
> +	wcd_usbss: typec-mux@e {

-- 
With best wishes
Dmitry
