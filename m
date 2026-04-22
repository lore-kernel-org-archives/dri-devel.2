Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 251B1F94CC1
	for <dri-devel@archiver.kernel.org>; Wed, 22 Apr 2026 03:37:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3D43610E1A2;
	Wed, 22 Apr 2026 03:37:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZyQNZ2jf";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fLBfBRkm";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6B76F10E1A2
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Apr 2026 03:37:36 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63LIZiUe2965895
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Apr 2026 03:37:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=ZgBxZbAMHMtUWTZdPqMVxZ9e
 C58y9vphw2NGsw5EX7k=; b=ZyQNZ2jf9C6uE6Sdowmi9xhIauWPyS+8udKlbP0q
 Z8pDHrNfBLzcyLyhaqF+ja5v4aDqK+AzuHewowJXi5FWMfzfeJ9HXxKALkGrNZ7k
 sp7m1RuQ0nMb26o7931vK4trXoxZxiNS2rN/uTa9K77jAe0RotbhfbRssk8QAW25
 lRATgDT4IsmKiYeXtQMcFsaBn2VT9UdfjsHK9bfcm3mQq7Rm9+g672TEbYf7OHBg
 N5QEVbImN6yOOfB3gJGqDAI1LK8kv0/UirUNbHmHO8N/eSkaX+edBTbAqHlYGA5F
 Wfft7nzvwJKlQGmvPmPHGeWzUrJY5ZCDdj54Pad1H2KSFA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dpenfhens-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Apr 2026 03:37:35 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-8eb04352924so551466685a.1
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Apr 2026 20:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776829055; x=1777433855;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ZgBxZbAMHMtUWTZdPqMVxZ9eC58y9vphw2NGsw5EX7k=;
 b=fLBfBRkmEcK9bbtXH6/DqUGzTLD5lLOOLLJny8hOWxEUi8EGYB4XrKxXMzhER4Dz5p
 D+kb0p+bE8TSBZKpm1EPfUiAPl63sKYLp6aVrh29JNLA/iSGIyQKv9xVMDZmeBo/kBb+
 67wLXKNA3WPHBw4/Nx4ersCuRnQrjGupbDwHHXeHGJPENg0/aTqhXbfRzYKiuV6F2bLD
 YW+ZmLERztUzMOk2nFo16WXfmp0D45cZmTPdq3nVgoRs5VOTgQXUil4FpedYI1n8hMzQ
 mQF8JjsAaMgKiuFwV2I8vBYBSHINH0dia1tcjlsxrDjcw2suET2fnIOJm/ge5U+X2hxy
 I3Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776829055; x=1777433855;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZgBxZbAMHMtUWTZdPqMVxZ9eC58y9vphw2NGsw5EX7k=;
 b=fBWTKXM4XF0XjAsCaPaqK3gS14KfKAJqUpKhhbJgVraA9UYbQhWdJ0uaIKPGt3pkrh
 WtBA6dCk5H9hzBSDsjNYO9n9WF639yppoppVm1Pj2VJazjGYaYfgxfIG2owuEh9fIwie
 n2pDk/doVOf9j90N9JjTTmQuU15KjrYNkztfsGcHBiXpw49cnPhjRI6oal6R05RU1uHt
 GEshA9nIo8HGVOdgybMYRr+8zRWO+MeAgpOUlmdw2dLmqV5hiGqPL3klR+mAQES53ZwM
 iTGwyQ/aJdU0rwMORZlNezSkbo8JCqdOsNwrRv+evIIjkBoQDzWgWVJz9Ce5TR9ttU2h
 Elnw==
X-Gm-Message-State: AOJu0Ywa99Bw80DkVO7ezuImWjowcdpxA3Fk0q/TCc1FKpCSuKhLk7aR
 TwKDwv3qicP/IGqYwkhMqLYm//qtJyP8M5MmuOlK0xKXBAJwS0FUT+ItgWFAoN/IqgK3rgAM1wt
 JXmlSupCGPxP4GCAAC5chdf3f40Ed64LVyAyKoTh+LZuns22+1Tu7uHbi4JgnLbSE3B5bAsc=
X-Gm-Gg: AeBDieuUBhYZPBCNfArWDPoPyBp6R1jHkC12a38FrZL5fh9Q0Rk0V8Fb/jtIEYDnW66
 yhxvjvuYbxOL8TEw2DS5n9j1ssBeYSaJoWvuYTq0SKZ3ixk9LdObJbQbEjMn4MnE+dWcPamwrST
 UZ7WEMPWbJrdpk9vCzDnuArkOF7hslnYsldfIOUIDl6+d3mdtNogEThFj4Z26R5EijeiLZet8FI
 NtkvX5z5rYu3m3iQqUR0NJ48QsW7nLiwFCKle/7Y1GI1xZo2Qu/QtbuywaIpoBZIwD1KWQL8hIg
 0TCgGnkil+8jS6c2UlOiHxBReDE5OAhEhgrF4TEcFaneub2eR16DoXtMRYUol/hOLSHxUj0Bxs1
 /LOR2MNRpDMkpOfNFpG9tP5IbDsACkQPqD02eRl7p7Xb53Nu5182vMaiinoxqk+nc+DQ2zM2u6D
 IJZHN+8WhVH4hiSOxQ3Uk1uv8jvsEg7t8A/oRw9dIPAQ2i3Q==
X-Received: by 2002:a05:622a:1b1e:b0:50e:a1aa:2cd9 with SMTP id
 d75a77b69052e-50ea1aa2fafmr137315841cf.15.1776829054840; 
 Tue, 21 Apr 2026 20:37:34 -0700 (PDT)
X-Received: by 2002:a05:622a:1b1e:b0:50e:a1aa:2cd9 with SMTP id
 d75a77b69052e-50ea1aa2fafmr137315431cf.15.1776829054348; 
 Tue, 21 Apr 2026 20:37:34 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a4187ebf9bsm4111620e87.81.2026.04.21.20.37.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Apr 2026 20:37:31 -0700 (PDT)
Date: Wed, 22 Apr 2026 06:37:30 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
 freedreno@lists.freedesktop.org,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 09/13] drm/msm: Add per-context perfcntr state
Message-ID: <wfarxotu3lb64ncqmohysmyrdsneg7lgvq7kldcuntshtciob6@nej7bduzff4w>
References: <20260420222621.417276-1-robin.clark@oss.qualcomm.com>
 <20260420222621.417276-10-robin.clark@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260420222621.417276-10-robin.clark@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=Y6rIdBeN c=1 sm=1 tr=0 ts=69e8427f cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=N42bA-zqoIAmhXTfU-YA:9 a=CjuIK1q_8ugA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIyMDAzNCBTYWx0ZWRfX/2lX4CJK7gWm
 YpW/QYQXcIYQhpJIUejby0ZeKsTnPipU1aI8XMEzI2JoKG0rHfp/9WYadAafz0q1STOnASICWdh
 q8JrbAoL89E+NdPycg5OFwOx+2WBrMgt2Uf8OHLbKmZX7hvISkf87zmjHl2ybAjKVA4hk6bkiIp
 cm51KTUgVVepumd1UnGykhuHJ3o4COZfAHneXOak8pBivgHVpzlQVKM8oNKiX61w/u1NxX+OLMV
 pbqb4u5AIohTXPHuqMkdXc2MvODNTXnyo8tWpRKqRcSjbefl7/TbVqwcKCaPD9RU7xXZtwH1pNe
 cIjxu2F45RoTB4lsDT6rQM+YhhARpWvga9l4Aut6WSVOl9TP1mBvyQ5Tne8hqNCNIgBOLOLTTEg
 bkW/jxI+g0rswmBHMsWTway0tisS0QryEGKX6fiSmkVEwOG/TG/VMFzrVwcH+fQfr/5Bq4acw7s
 kkzoIVWxB1TPJgGENrQ==
X-Proofpoint-GUID: 8T1DyTeQ6QUHHvXa6WrC4s78juGRLbYa
X-Proofpoint-ORIG-GUID: 8T1DyTeQ6QUHHvXa6WrC4s78juGRLbYa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-21_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 spamscore=0 bulkscore=0 suspectscore=0
 phishscore=0 adultscore=0 clxscore=1015 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604220034
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

On Mon, Apr 20, 2026 at 03:25:31PM -0700, Rob Clark wrote:
> The upcoming PERFCNTR_CONFIG ioctl will allow for both global counter
> collection, and per-context counter reservation for local (ie. within
> a single GEM_SUBMIT ioctl) counter collection.
> 
> Any number of contexts can reserve the same counters, but we will need
> to ensure that counters reserved for local counter collection do not
> conflict with counters used for global counter collection.
> 
> So add tracking for per-context local counter reservations.
> 
> Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>

> 
> +struct msm_perfcntr_context_state {
> +	/**
> +	 * @reserved_counters:
> +	 *
> +	 * The number of reserved counters indexed by perfcntr group.
> +	 */
> +	unsigned reserved_counters[];
> +};

Fails here (Debian, trixie, gcc 14.2) with:

In file included from drivers/gpu/drm/msm/generated/a6xx_perfcntrs.json.c:7:
./drivers/gpu/drm/msm/msm_perfcntr.h:130:18: error: flexible array member in a struct with no named members
  130 |         unsigned reserved_counters[];
      |                  ^~~~~~~~~~~~~~~~~

> +
>  extern const struct msm_perfcntr_group a6xx_perfcntr_groups[];
>  extern const unsigned a6xx_num_perfcntr_groups;
>  

-- 
With best wishes
Dmitry
