Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 354A2CA9ED2
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 08:12:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 968AB10E3B1;
	Mon, 12 Oct 2026 08:12:35 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1ED2A10E3B1
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 08:12:24 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69C7hSZp1695018
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 08:12:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 QDsfEPhwfstGXtyIHPjDssEUUvE4bGtbloleL923ipg=; b=Sx1OwxOoXjciOR6r
 igtohScS1Z3Mpl8wxvVlru42qxvdWipxhn6Yw3IizENNfVNb6bAL2vJA4vaB7E+2
 JTieuDGXBO4OT6t871I681OwzMarPoifYmHmrZ88/sIFghxMm2Zc2KDkdHj+boPv
 x5AS/e1GihsmsTrrwg/3FuxLOrBoJDEFPJv9A+4BzcvdWoWhpr7rpoVLs/ObcpJx
 hsOV/h7xPA38QnNdUCCNlfb3UceYuVzq4/6EkNfyzXXX19ZW8wUtfZ217Hdnn8hL
 uRhces0afrfyZLfgQVT4UpR5e6XNgnUMXNZPBMlrCn9GRS2DdhcCuWT5pu0Dx2ak
 En9pkg==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h8udq03kx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 08:12:23 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-91b561a5ca4so5589416d6.0
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 01:12:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791792743; x=1792397543;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=QDsfEPhwfstGXtyIHPjDssEUUvE4bGtbloleL923ipg=;
 b=Wa7uaNZQqkvhrcNVvRCDK9dw8ShfO9SZaOi5aADFHjkV3YJLp27ehN85vrZgpl9rzD
 ZDD/yV0mzq8pvBXR/s089sKRsytUEOlXNE1bN4UMtNySNKOUhz2JFBQMJY2BFidXG/t+
 6oh+J3Wwx42bCI5IiRUNjW2jAPwhN+HL3M+M4VkSNSopZjQdDHEe/6YoEiAb8dUAhw36
 UZp7S/2AWxbrmsn3W5IPlDkJDhGhN2g96rJgaznIsHq2YafB/MHuM/hdAAEIOW1JsFgg
 XRZs2Wt2bdvi+c0GWS+iGVlU36D0bCX8RmQMlFyljC08OJSWlhULHqKHgCKkT+AcMlH/
 5MoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791792743; x=1792397543;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=QDsfEPhwfstGXtyIHPjDssEUUvE4bGtbloleL923ipg=;
 b=kWEceBHbFAMUHHknpbVzwpLOgc8XW7BbhGecf02aavjKcw2/vM06uRYCxXCXoLV2Mu
 hLF+ivnSvcsAgT5sKkpp8hvE+jFEn/qYkIEAHI5I0fRWdSIw4GSy/ymXrxeOkcnByfb0
 y47R1jajFmQoHJW/zmSjOiS+vRp6gWYIYn/xzOqISE1HC1IjAeWL2CCNLG1tieW0WyKw
 Y0TsfeCm1QJRfqZ5EmHNgqqQ3BdfnXC+iCEViPUYCj5UBXwpXqZuNd3F8x0oZ8nhrv39
 lQU4YQ4kdchzSzXtL0YG1BXBMx8N1AXh9pmEuUcN0N1JqiOj8GWvoCNMOZW97LDEoFWc
 9epA==
X-Forwarded-Encrypted: i=1;
 AKwUvByvdHDo5gmJWGOokbYakg71qMEez+bPKpp72qcR3+CW0FiPlA97HxBI5RdS1WdEaPRUW+EYHDQu/94=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKLdkfGN/6A1WeOKBEMZZwFBhfdNdFMxaXRwj6gnDmTQ1+DNgxL
 72cVdXhySRbpr90BvVVqaI0aLOtfC8AnWQX42npD3s7E7dsBqeOKzAlEvCEfc7QB65BHO44rxJ6
 LzLHo0UYaPVaW0UAB+C2bwz6m48zihP8O8MNOzkfM7suhs1nE47Kqik4J2jZSZ7JATGp4OyQ=
X-Gm-Gg: AYBFou3wquBgHCLVeeaQO80UcRh9JxoJ7iLRR8s+DR3XPW7pzZ6S9pJHQG7s8jdOolM
 5eblndCdXurVaR2Ql3tWV3n5zYFphYQ2dmTqEAinIa395cGrCY0zADZlCeBT5DbKeRzDK2NlyLd
 uQuYijFpoNzH4tymCmka12iUFNp+WBOdehG8WLAjYOCGmE9auOBVUbpe7SKqkfj6G+mkerOzavp
 /AqOsz79oU5PyHCnR6Zp70h4MnlEJi8dj9gRd1vkN02ZIbFx1u7MY9INs8gB70megDUghJfmh7I
 Mf4dgAsqZZ/3/yIhP3wW4TCruoNA8EhKcpKiB4WnFakigTrY257Tmlo+RRUPicSVn+c9nq1unUA
 AbyFvsCmLGYP1TZh21tiLLA==
X-Received: by 2002:a05:620a:19a2:b0:93e:54d2:2283 with SMTP id
 af79cd13be357-93ebd2955edmr1592996285a.6.1791792742670; 
 Mon, 12 Oct 2026 01:12:22 -0700 (PDT)
X-Received: by 2002:a05:620a:19a2:b0:93e:54d2:2283 with SMTP id
 af79cd13be357-93ebd2955edmr1592994385a.6.1791792742285; 
 Mon, 12 Oct 2026 01:12:22 -0700 (PDT)
Received: from [192.168.226.26] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c31a9767227sm427742366b.11.2026.10.12.01.12.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 Oct 2026 01:12:21 -0700 (PDT)
Message-ID: <582fe88d-fb5e-460c-b67d-a06072c64fe2@oss.qualcomm.com>
Date: Mon, 12 Oct 2026 10:12:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] drm/msm/a6xx: Move a702/a704 to a6xx list
To: Rob Clark <robin.clark@oss.qualcomm.com>, dri-devel@lists.freedesktop.org
Cc: freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
 Sean Paul <sean@poorly.run>, Konrad Dybcio <konradybcio@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar
 <abhinav.kumar@linux.dev>, Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 open list <linux-kernel@vger.kernel.org>
References: <20261010154125.726149-1-robin.clark@oss.qualcomm.com>
 <20261010154125.726149-2-robin.clark@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261010154125.726149-2-robin.clark@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=evJKXYpX c=1 sm=1 tr=0 ts=6acc9667 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=4hOvTdViVUcvaw6_JQoA:9 a=QEXdDO2ut3YA:10
 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDAzMiBTYWx0ZWRfX/vX3brS0C7Ul
 60Im5C6iQQcNAUE8PZlc7fahRuAtmCr3dG+nMaVGDZ0uXl9oJqHTv4SGOhcmwlxKDkLmbBpznyO
 wsyoFjU9a9kh+z2qlR6uC86pl5WM7nw=
X-Proofpoint-GUID: i1XQDOJWbwI6KgMkUb5WmtfqWWNgytcr
X-Proofpoint-ORIG-GUID: i1XQDOJWbwI6KgMkUb5WmtfqWWNgytcr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDAzMiBTYWx0ZWRfX/fPKl1YXuutv
 0lVdYSguYAR3tLk+Im1ZqaScAodxx9PifFBi++4nszepc2vYhtRks0N/YNO9h7olDsrdiXBNPL8
 UR929GGawrDc1qSm53BSc/9pHZJxN3CHQKV/OIXiMLYmTAKqh6TpUach8AIG+OSf4VqohEE9KKP
 P5v5YtIMkgKQ9vyJaEK1AfYCzea/YPhv99E7giYKXycFt/fUnToDQE9zxsvQQkHVM4UYFE92U24
 ahDfpwjA6tzd73gEzNOPrJKX9N6zRW6U5AL3oemqnhRfo31lEfeA3+Qy/3E+4y/ENT+ymfh/E7U
 19M6CyYDQogLVgTfuGDWt1k9tFRVD2WfDtax4oErZF0B+0y6/2ZTk9CloEBfmTY7Mi2LT+zjIYB
 WkbyhfQ7O2qs1wnx4G6nndIfnmvRTCx7u+aR4a47/4jqQ1dvmeJeNP+yWF7HzlWPMvqUKhMZ5vc
 VgTXr+LTAP6XpKVl2IA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_02,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0 bulkscore=0
 phishscore=0 adultscore=0 suspectscore=0 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610120032
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

On 10/10/26 5:41 PM, Rob Clark wrote:
> It is a bit more a6xx than a7xx, and this simplifies the next patch.
> 
> Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
