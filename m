Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7A44CA5FDD
	for <dri-devel@archiver.kernel.org>; Fri,  2 Oct 2026 16:54:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 094FE10F91D;
	Fri,  2 Oct 2026 16:54:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="gfFy4hUi";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="V40mNmfv";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B141610F91D
 for <dri-devel@lists.freedesktop.org>; Fri,  2 Oct 2026 16:54:22 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 692GimkF1834387
 for <dri-devel@lists.freedesktop.org>; Fri, 2 Oct 2026 16:54:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 hX1xIGHHDooaGka+HXLnczXa7BVx4zuQ7NYunE/26TU=; b=gfFy4hUiW+vRlYvL
 w+n0LBB5D80p6R61k2IN4LwIbpN/RyKYij3Tl//E4xRP1XJMOTWXC+p0f921FEsh
 m6P5+PcaodR77rQsnY6EjAhcgf1nH1qqiHdvrCaa3t+3KLiUzoUdCMvXNPjh4Dnc
 NfvsS033E7to4QZ4MtNxmvn35ZP6LJsawDpOd6ymyFHRWdjYm/h3YjZRWO1EVCSl
 WPkQcsKKn4JfI9JpY36Qi+dZMemrrE/Av9tZaFIHsqopYGoFUMralWYeBER2xUpe
 EYOsXxkzVTy/uRVO/M5PyyJM/ETV73SORVyefcfXjc9s67xrXn6byJNIcfZOsaoi
 y6r4SQ==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h2ec98jux-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 02 Oct 2026 16:54:21 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-30c0d568830so15105988eec.1
 for <dri-devel@lists.freedesktop.org>; Fri, 02 Oct 2026 09:54:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790960061; x=1791564861;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=hX1xIGHHDooaGka+HXLnczXa7BVx4zuQ7NYunE/26TU=;
 b=V40mNmfvNhWAU+aoOyn7WrqKscnNx3BScN6mwNseNke9xQeLt9XBw5YU3a6aO79Ve6
 APiyNjI0VvzrC92fzSANtWdj+416IkT94yRUetEnSR241a7aAZoxVUfcGu9tqqcWPnHy
 hWngJ8DcNW7VMnV2P4R+Ktc089i3k5tHmplsyKdIX03qskjrEK/c+HD6e+IWcMMKXedl
 ul9uTpx+QiACEJ00S3D4u2RovCR+6m+wfxUwiGG6GlUpoE3BYDkrRUbBAWSilphXpd6o
 S//EsGxqX1brydhAF+2it2d0ekJ+mRYPBOJmw44hMC8Q4UfhLOFD/vhRwuHGnMeW9Tvr
 EYeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790960061; x=1791564861;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=hX1xIGHHDooaGka+HXLnczXa7BVx4zuQ7NYunE/26TU=;
 b=gvpzHQoV1kVMhjJM/FWJxc06m5UD1N08ubuFC64sGG8xe3HKd6HT3ZN0a68AnvAdee
 x+CqiIiRS3J8beC70GAgDxLzjQ/xhHHuy8wnH7gA3j3vbNMZLAWkbWeGpJg7n6U4Xvqv
 4TCdgcCvPqOaIDXWn5MDv+PoeceVU/HVPCUqNYMlfryqPkckKGLRBy70SdaobxLgNmwv
 6AF1jYt+PWGZz4fAlPIEu/2vN2ZLkojuweYcTQnsJza+kCuxqp0bMts3Y8Jh+p9WyQty
 wPUwVtI8ledOvWr7jDL7F4dIbb95GutzaiPc2bUKwmBdOVHblwV2cm5uNqnWguOnnB9A
 VhDQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxwJYgPzWwHsQDSbo0X+P5crv6ybMw8y85++i0EpHT6u3d1n6UM93Fpn+4Pv/VOdRzQlTuVJgLfQtw=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kzUSr7qO9iCq71u3/eD6eJvgmmTSJgpTU7qiOMzIJgELDXyiDH
 6Ba4Kc+msW6f43cpZrJ5M9311tfpaRF3gB3qktH2cILv32q9pCtfbnmdXcbiARoqFnQNRTM4CCe
 854XwV3S6rUBN4K8Ewewjv1F5pSFf052n5D0WWEZH2YrXI2xfQ9wT4c3HMm1HMwIR4K6QWR8=
X-Gm-Gg: AYBFou00i5s7A0+eapdJUa1s7h1ec/DIFxPJififC3D2PlD/KgsHvBT/tfy8Z+l/XqJ
 mAsLlny65pcoubYtKP6WteSgeWlEXOC0G7UzU+pnos42qPNVDrAchroRhQtb14pL18cc3wIWT5n
 kzoqhl2wg2r8gbyVf6fIvWdfPd4v78c/J0DsKijd0I3gaNGl4SKIodULg3tdxiqnoBo9HqvQ/Ei
 LoO+hYizxF/2uJqzLfjnZx3LiBvHm8RCoUvW83DpEOU2PS3r8omL0nnd9HAWHtVjXju1ggc6L3W
 /IQw+pIqjZI4THZ5jFe7jHO56ZsylFbARnTBrCgY14BEMKHBMK8krjT1VHosS5Quxfgc3ValZqb
 Nmkucvkj31jqoD2cqVHRUJ8mYSh0hxvPNXJvXN2pR4ZuyJfZ4UQ==
X-Received: by 2002:a05:7023:a8e:b0:144:c12d:c6a3 with SMTP id
 a92af1059eb24-14f5d1b778amr3833459c88.45.1790960060668; 
 Fri, 02 Oct 2026 09:54:20 -0700 (PDT)
X-Received: by 2002:a05:7023:a8e:b0:144:c12d:c6a3 with SMTP id
 a92af1059eb24-14f5d1b778amr3833415c88.45.1790960059958; 
 Fri, 02 Oct 2026 09:54:19 -0700 (PDT)
Received: from [10.226.59.182] (Global_NAT1.qualcomm.com. [129.46.96.20])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14f810bb13esm6472764c88.13.2026.10.02.09.54.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 02 Oct 2026 09:54:19 -0700 (PDT)
Message-ID: <bb26e5a3-6113-4593-ae38-e16da9591690@oss.qualcomm.com>
Date: Fri, 2 Oct 2026 10:54:18 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] accel/ivpu: Move register poll timeouts to vdev->timeout
To: Karol Wachowski <karol.wachowski@linux.intel.com>,
 dri-devel@lists.freedesktop.org
Cc: oded.gabbay@gmail.com, lizhi.hou@amd.com,
 andrzej.kacprowski@linux.intel.com, dawid.osuchowski@linux.intel.com,
 Tomasz Rusinowicz <tomasz.rusinowicz@intel.com>
References: <20260914082649.891871-1-karol.wachowski@linux.intel.com>
Content-Language: en-US
From: Jeff Hugo <jeff.hugo@oss.qualcomm.com>
In-Reply-To: <20260914082649.891871-1-karol.wachowski@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: FQhX7kQkDguowf8mFzkp82vYYcWYdo8r
X-Authority-Analysis: v=2.4 cv=Ie8Symqa c=1 sm=1 tr=0 ts=6abfe1bd cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=QyXUC8HyAAAA:8 a=F60lk71BOrkGg07CRk8A:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAyMDA2NyBTYWx0ZWRfXwmE+AtvCK9Oj
 JINQ5MrKpoKZhVPVFvrEpReuata6PCVFQnR46hJV7P8wgoduuog5ovZH88QehuesUav+ecFkDs6
 xBhOEMQtxPoRYDCdk9LYbzsXI1zIGvg=
X-Proofpoint-ORIG-GUID: FQhX7kQkDguowf8mFzkp82vYYcWYdo8r
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAyMDA2NyBTYWx0ZWRfX8tbMCqfa/3cj
 K7gfp5nPTJPc/3qHoOysgYSAbvbxuvi9qu4O4UHoA76sEecygC3P9/xxvVYvI5TR/cNvqkF8U5F
 ozoAn7QaITb4oM76WCb9svxcNLsUco+qedBJgxHQjkYPknJhkPKP3k5+7roFZVl7IaCgAnmnYH/
 5tRDEdGHqgjs39nqmz8klpsMLxNaiLPByP8pYsUN5W8YuP42R+/GCfekciyqTf+6EmVG7gOi7rP
 TgdV3sjpGowjYGs8DpF+stAmiP8wFtu5w68w7Io9/NW9HPhfgeICJyrQiIHE1wErGmCGi/+pa3e
 8f8D5b0fAF9elGOEmjBBJ4go89fFTWP9YPflyO5fmMvgk72uSyc/9EiRLNHxmqKWlBfJ4cqNOM8
 jHW7U1BqxpCf5SXkpHql83X16YrQaVR1JGl9dPoKZ0puRnbycGKgnIYyrWHZYVav0wQOjjxin3t
 j8c0HeIKPwu2U1PPKNw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-02_04,2026-10-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 malwarescore=0 suspectscore=0 phishscore=0
 priorityscore=1501 impostorscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610020067
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

On 9/14/2026 2:26 AM, Karol Wachowski wrote:
> From: Tomasz Rusinowicz <tomasz.rusinowicz@intel.com>
> 
> Use the vdev->timeout structure for register poll timeouts. This allows
> adjusting those timeouts depending on the platform type.
> For FPGA set MMU timeouts to 10x.
> 
> Signed-off-by: Tomasz Rusinowicz <tomasz.rusinowicz@intel.com>

Karol, this is missing your SOB.

-Jeff
