Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06EDECD5BB1
	for <dri-devel@archiver.kernel.org>; Fri, 22 May 2026 08:08:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3B05C10E18B;
	Fri, 22 May 2026 08:08:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="nigQhwFN";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GxgxIV5U";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 428A310E02C
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 08:08:00 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64M41mnp3005135
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 08:07:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 jUNAGYZb+CIimh/bVdbWuR2xAAKW9q7QdkIq+zmBuDo=; b=nigQhwFNgVIS4FW2
 HSIV6Qr34wdjCf3OtC3qxkBJ9I4Nukv5J3PS7VC7lid0xrc6UJtcAbqxtU5/69MH
 VJOnj35YXW8bj5DM+Dlz9ex7bEooH97zx6Qkl8DdSPSqYZiPlQeqa3jx1Vt/6Vi8
 Ii1amrIMYeBTqx9NbX5eijxY1Q5DcymLZuhygVPYWhK/vacwaTVHt61FtsamRICk
 tL78e2lLO2ONyERZOZHLlojPZdCM4/qUBLZ2wBcdRLXEgMKoVAmIt4kvpiQWdcNv
 zPwStrYwaduSCH34cRs1BfMA7xDP0PEps4zW/sdYD7kKf+yHKzqQYd6FKUKsFDPR
 qNqtLg==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eafrt8v1c-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 08:07:59 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-c70ea91bfe1so4027118a12.1
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 01:07:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779437279; x=1780042079;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jUNAGYZb+CIimh/bVdbWuR2xAAKW9q7QdkIq+zmBuDo=;
 b=GxgxIV5UfnU4MWxCTrQz4hY+vvYs2+GQoANNWEJdvS3r05yxEGBUKfrGCLTljyn8rt
 8Mnbg0YgwK2rG5I9z3TiEPZyJDVpkXYHUgnf8BpKa8jjWMnoIGG+HCak0H/kKNZmtPWZ
 kfr58NpnaRsO3P6oNzsZsOjfWUaKWUtp/DqoeErjf08IeqzeBKzghdZFtnkcJnH0iHdw
 M4zEdyMNkkBW+tfFgz+T2caz0oE88zM6PpUNZ0+ScbABLowJJlov7KEz/4spCCCojSTv
 ygQhFI1tIMaDErvmLS5Qo/Oq5+VUnuSCim+Mmy1DP9CoJ9QFAQJSEOsS3RrNFXJNQpTa
 pAMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779437279; x=1780042079;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jUNAGYZb+CIimh/bVdbWuR2xAAKW9q7QdkIq+zmBuDo=;
 b=nCdFU7q453Wq3Zlr9fcRDoVqfwxt+mqBF8lhLOUucJYorzm/JaJepsglROSBGkUVVP
 rQ7x7aWLbKH001Gamqeu/jusXV4pwaQmmhBN4nDT8k2+kDVM3XErSHDkBZWqDuDCpvyn
 8jorESC92wE8dc6+/h+uQ4bF5/i8azAvID6D8Z1V6UQw1Xsxz1ToYujcRDSewem2koXd
 +9vFdme3bksFCTm9VdZRlRWTEvjhS51BBufWz5w/K1QmdiFHe4/Qa+DgigLGQqxa8h7v
 eq7n6X/1t74jJthD4oMWEg+Ql71ARJwcvaandrS3XWqd3+pQb7ck9hnCOiehW3bi++Lv
 V7OQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+W4lIATX829MpGrP8ovXFvxNmpL/LKHnlogJUFkbP8GVMahQuOoCsIbY2q9sH9N5WnxVZ3lLFuzQ8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yyj5xCuKXorKKmvzb6J6fZAbXeVYHHBk1T7+2bvWKosudRm1b/c
 A98PTbjBlKRo6u0WvwwrrjrvMSHn9m42118AcaHTPc+bAF5UiWHQq91j4sB02czUfRM/K84qm9J
 Bo0sO0nWQdUgDgKjOwayxKOoOaGBFmbKcFXFJn/VByCj/Acs2Td2E+l9Yf+rGA1zL445Yhn4=
X-Gm-Gg: Acq92OFNqMK9lePN63hekzgH+00xONNSCco1rMP+rtaicWs5NGSivUFprS+NB/RCkcB
 IfnsnaRwXbXRg/dzXBAJvOf9C03fcjpr1MBea7p1m+8JUwUD2uHYcu7+kr/anKszNRaQpdqPUWE
 mAp98j7xBF8xQVMePXEOPEenlvErSuya3eejvha/p+RXM5kivACjgyAIB85Z9sdbX+Ws0L/gsMl
 DjxA26pVW6Nzx2ecYmN2CI1b8SNNXb4fnTPKxPpcsaT4tcLYVVmau4aLkLwOHoJ1CcyEBZZLzb1
 TGJHJrNubRme2ONks/HFkg28qEFlvTOOGIJGgLWTgIQynXxHC0xifguHgQf+bj1JG/rj8JfqDd1
 u2wPEhuj2/Lg+Y4D8FAzwDuGrBd7lNV10/fy6s0JcIJ5udAl9RVWx2whwwZN70lVv+fBa01VdB/
 BLuBevMWjk0id8zHq50g==
X-Received: by 2002:a05:6a20:918a:b0:3aa:c93b:6266 with SMTP id
 adf61e73a8af0-3b328c98e37mr2772591637.19.1779437278956; 
 Fri, 22 May 2026 01:07:58 -0700 (PDT)
X-Received: by 2002:a05:6a20:918a:b0:3aa:c93b:6266 with SMTP id
 adf61e73a8af0-3b328c98e37mr2772552637.19.1779437278436; 
 Fri, 22 May 2026 01:07:58 -0700 (PDT)
Received: from [10.133.33.148] (tpe-colo-wan-fw-bordernet.qualcomm.com.
 [103.229.16.4]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c85205855dasm949585a12.31.2026.05.22.01.07.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 22 May 2026 01:07:58 -0700 (PDT)
Message-ID: <c5934946-d2d7-4bb3-86e7-9de11db5e85d@oss.qualcomm.com>
Date: Fri, 22 May 2026 16:07:52 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 00/39] drm/msm/dp: Add MST support for MSM chipsets
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar
 <abhinav.kumar@linux.dev>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jessica Zhang <jesszhan0024@gmail.com>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Abhinav Kumar <quic_abhinavk@quicinc.com>
References: <20260410-msm-dp-mst-v4-0-b20518dea8de@oss.qualcomm.com>
 <bmkdeyquoyvcwcgucijcxmgnip32fs4gyqe6gvponokwiu55cf@7ncsbggx23ar>
Content-Language: en-US
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
In-Reply-To: <bmkdeyquoyvcwcgucijcxmgnip32fs4gyqe6gvponokwiu55cf@7ncsbggx23ar>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=JN0LdcKb c=1 sm=1 tr=0 ts=6a100edf cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=e5mUnYsNAAAA:8 a=EUspDBNiAAAA:8 a=SOlSXIn2j7jxmtBtDG8A:9 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIyMDA4MCBTYWx0ZWRfX5tsqHloPLTfB
 HO2LYkFe2xKCNQ1Y6vWwUhiC192G3557rbvGw6MhljV95v2Byb/Y902nle3fex2UwEDbxC1udgZ
 eSLWajNOOyObVr1+6uLkdlnkX1fu7Zf2ULbio8+r7sqOXVZqswzysdANVuPqQaTXZDrgO/MLV9E
 DXk4FAlPbKztbon1GFBhfx2kf9ZfBMsy7L9YokcHHBTX+Iok4qML3IMlaLdaCkkJUhsBz/Bi44T
 K3jmFwmh73z15cBIVeqV0LFJpmSyurRUhHQLDlxcyS8GJUFgldVKRL30o4tkz7RYapIOnFWCkge
 X2Np9hiW+24qyYqnv7V8VZXcL9RP1xZYB2xDtAPJKiahzqNMBD/D/rneOILX+DHwUtYJONRqC3f
 e8UjStMNw+6H4mYgNZo1ouSOAc/sGqirivPNqc9ybHH8mjEHKSr6r1FcU+tt9zYfYtP2QHibVlF
 F9FfiTskG7gKp2mrs4w==
X-Proofpoint-GUID: US1SoMm2hFTZU91HRHI-qC4UMHDzS5vR
X-Proofpoint-ORIG-GUID: US1SoMm2hFTZU91HRHI-qC4UMHDzS5vR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-22_01,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0 impostorscore=0
 phishscore=0 bulkscore=0 clxscore=1015 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605220080
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



On 4/12/2026 8:34 AM, Dmitry Baryshkov wrote:
> On Fri, Apr 10, 2026 at 05:33:35PM +0800, Yongxing Mou wrote:
>> Add support for Multi-stream transport for MSM chipsets that allow
>> a single instance of DP controller to send multiple streams.
>>
>> This series has been validated on sa8775p ride platform using multiple
>> MST dongles and also daisy chain method on both DP0 and DP1 upto 1080P.
>>
>> With 4x4K monitors, due to lack of layer mixers that combination will not
>> work but this can be supported as well after some rework on the DPU side.
>>
>> In addition, SST was re-validated with all these changes to ensure there
>> were no regressions.
>>
>> This patch series was made on top of:
>>
>> [1] : https://patchwork.freedesktop.org/series/151522/ (v5 to fix up HPD)
>>
>> Overall, the patch series has been organized in the following way:
>>
>> 1) First set are a couple of fixes made while debugging MST but applicable
>> to SST as well so go ahead of everything else
>> 2) Prepare the DP driver to get ready to handle multiple streams. This is the bulk
>> of the work as current DP driver design had to be adjusted to make this happen.
>> 3) Finally, new files to handle MST related operations
> 
> General suggestion. Please reorg the series into the more logical
> chunks. If you are touching enable / disable path, then continue doing
> that until its done (more or less). I'd really like to be able to merge
> at least a part of the series in the next cycle, but there needs to be a
> logical "halfway done" moment. Let's define it at the "all paths are
> refactored, all booleans are in place, we are ready to get MST parts".
> 
> I've not found a use for separate bridges in the MST path. Please split
> the functionality between the MST connector and, maybe, another private
> object for generic state (like connector -> encoder mapping). Other
> drivers don't have this issue because they have fixed CRTC -> encoder
> mapping. MSM doesn't so we need a separate way to store that. It's sad
> that we can't subclass MST topology manager (or its state). Maybe it
> would be worth changing that and letting our topology manager handle the
> assignment in it.
> 
> Also, I found a set of warnings while trying to build the code. Please
> make sure that there are no warnings.
> 
Got it, thanks...
Does this mean I can send a subset first (rebase on latest linux-next 
and ), for example the first twelve patches? They are mainly clean-up 
changes and do not touch the MST part yet.
>> Note:
>> Validation for this series has so far been done on the latest linux-next
>> on LeMans, covering both FB console and Weston.
> 
> It wasn't. I couldn't apply it to the latest linux-next. There were
> fuzz-based rejections because of one of the patches merged some time
> ago.
> 
Will rebase it.>>
>> Broader validation, including additional Type-C DP use cases, is still
>> in progress and may lead to some follow-up adjustments in the next
>> revision. I wanted to post the current version first to collect early
>> feedback on the overall approach.
> 
> It's nice, but please keep in mind that majority of users use Type-C
> rather than native DP connectors. In some cases your lack of Type-C
> testing affects the design (e.g. for the HPD handling).
> 
>>
>> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
> 

