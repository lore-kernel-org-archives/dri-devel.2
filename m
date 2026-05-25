Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA571CD5BBF
	for <dri-devel@archiver.kernel.org>; Mon, 25 May 2026 03:30:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A977210E068;
	Mon, 25 May 2026 03:30:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="BR+YA7ex";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="O2UVj37l";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DDEA810E068
 for <dri-devel@lists.freedesktop.org>; Mon, 25 May 2026 03:30:54 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64OI02Oc2442267
 for <dri-devel@lists.freedesktop.org>; Mon, 25 May 2026 03:30:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 9ttDcIawSn5wHGMPcjxnIGUJLNBlKWRE6XzhIGYw9xo=; b=BR+YA7exBKoqJfyf
 IwhZWGrr7MBmRhR6IS2jPPb6DPtFRw5dIpxJ2IDCDzts1VBmK/mBbFIPeztpYkK/
 /qNQRmYiLV5Jt8RdvMMRf3vgq6+BZWjF8lR7mn39lf7BVA88oVBg199rBHmB25PV
 OH3wWIniaymv2qPCP31bfSNCBygBxwcMZ0wG+H/G+xQ2XCVxdDfN0V9KAPa6rm2E
 T96WgZKmn1oM1hs78DjJy1cHj6YMId3NBaTNtjo1eBG8vVXJLEAXMZPsxNu4+Pm0
 emrTDaeRF94MMRhcCT86VYwquaaknBhxGHg9NyIbkyfzKPytkxI9MLyuXrThJoZG
 BaKGEw==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eb36t4w4m-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 25 May 2026 03:30:54 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-36642d2f4deso18433809a91.3
 for <dri-devel@lists.freedesktop.org>; Sun, 24 May 2026 20:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779679853; x=1780284653;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:cc:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9ttDcIawSn5wHGMPcjxnIGUJLNBlKWRE6XzhIGYw9xo=;
 b=O2UVj37lri3snweAW3Kr1ykc7Wb/aEw6vYGHftt4DVzlT4SELDhK+/VnU1SLbYHDI6
 rf2QUAP5KDMvsXFD15Hcs/qZ0FV4uWxkwJA6zWUO8AJAuD/0Z6sBHiwco2A8N8VjuYgy
 9F79MPUEKmsrWWKKx9Ac7v2W+j2VJY5KPO+RUtKRYcrE/z2OkajCwWpkJnE/x7nNUixm
 Xm0B+BGECD3EYO2Z4mGddoUkSICb6JlpJL6i3nbogimRTkLpgmxFA77dupZUTskAHdXk
 +Rri6/iSVZtzhrn6vVrdVG1IOvQG9JiiBy3Xv9dc43eOmRl9RQALxUTBbV53Xl06N/70
 vLxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779679853; x=1780284653;
 h=content-transfer-encoding:in-reply-to:from:cc:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9ttDcIawSn5wHGMPcjxnIGUJLNBlKWRE6XzhIGYw9xo=;
 b=LmMr+RitA+khOf66oRJsHUH6CwmB28ost1p0ynmEQjsYJpo+YddJtdToH+KCSrJhkp
 S8IhlhmuMaV7etN/xF3zFITJLWny/Fo7+X/98ChdbzfK01puUCt+xfjJCIilVatUms08
 QnMXehU7OZaK+bAtl4zKfDZn3mCeucJSotxk2gCFzQSPS2pHC7ET6PWu56h++wYws3G6
 XS+oqB/c/a+zhgS1oAJLny3JTKESWg+0F/GA9V7IklF//jtDYIj4d6B0wL2SXTsxZ2x4
 sTL1k02Uxrv5Qw+crS9jNfXvo95+0ttSmXRLVEzbmw975S/AYYqOuM2HKNiJT8lVkVyK
 bLPw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+SOqNx9zngYZ8xb7qBXxQ/52lvJ5QbEiEoxHEj8ou5k4/tYuENtscZ7hbbZ35Q7tLC7JRaEP04HkA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy5+u5erewoXPA1pVq6DWTvh4uAWr24DVE/X+eanT11XSYYrYZo
 khthfFfZTAf+uFJgI4NY7Bc1ZynpqMWOCTHKpQq/9Da93rGjtgqUklpyanqK7TKf8h7GsnkaQGo
 c1Fd9tbWut6yAIDfS35emLgcKrXKIbyuzddea+RCYyC98R9473GQcIY0mKk8BG/s0oiXnD1Q=
X-Gm-Gg: Acq92OFbi55jFGqtA9260Ghmv2kHz5QvGtLhyag+cmodrVKM7V+w3TnzvF/T1UMsE9X
 jbmM2te53ZZQMNU87AvBkaM6GKafJPzIwHD96/YAZ/uwYsjXLhevFqUdmBw4T1Iq52DwF0CRtlu
 yEABhYnWtfkplGnynS2lvHCUtykTEhZ738/Jgn/1rtsggtdVJ8IY5WHoftRI+xkZwviSaoo1FAC
 BLAyAlZW85Sm3t4tm9/H7ddtXzaE78DhFNtTZdD3hllznHMok1alv12xv6PqgjgWsMq2SvEWMze
 lO1HjPhoyCFMGVbyDRGkQiW1RcJE0f/BEuqTm8ly7eQncpqCf5+iovDBlj1aj1JucduUSBmmVQa
 yfe3jN2Ri8oFyGDoojrr6hFO70bf+JujfOAFoUl5zh7T1Fokm6p70+RmohKpB6jVZQbSJQj4hMU
 CiTnaCH+1J04wE3Y7w
X-Received: by 2002:a05:6a21:164a:b0:3a2:bd1d:d679 with SMTP id
 adf61e73a8af0-3b328fd02e8mr13103524637.48.1779679853478; 
 Sun, 24 May 2026 20:30:53 -0700 (PDT)
X-Received: by 2002:a05:6a21:164a:b0:3a2:bd1d:d679 with SMTP id
 adf61e73a8af0-3b328fd02e8mr13103484637.48.1779679852995; 
 Sun, 24 May 2026 20:30:52 -0700 (PDT)
Received: from [10.133.33.205] (tpe-colo-wan-fw-bordernet.qualcomm.com.
 [103.229.16.4]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c85202903absm6598010a12.7.2026.05.24.20.30.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 24 May 2026 20:30:52 -0700 (PDT)
Message-ID: <d9248bf3-ef48-4c04-ad7d-debc8854bae5@oss.qualcomm.com>
Date: Mon, 25 May 2026 11:30:43 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/5] misc: fastrpc: Remove buffer from list prior to
 unmap operation
To: Greg KH <gregkh@linuxfoundation.org>
References: <20260515124217.20723-1-jianping.li@oss.qualcomm.com>
 <20260515124217.20723-3-jianping.li@oss.qualcomm.com>
 <xnkycubizpoe4rmhc3jt36ulx2fb3tubjybu3djovafkqqttmc@o6vw2so5ctxr>
 <37146a3a-b18f-40f1-b95b-0ac19bf6c07a@oss.qualcomm.com>
 <2026052211-pavilion-compost-5fcd@gregkh>
Content-Language: en-US
Cc: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 amahesh@qti.qualcomm.com, arnd@arndb.de, abelvesa@kernel.org,
 jorge.ramirez-ortiz@linaro.org, Ekansh Gupta
 <ekansh.gupta@oss.qualcomm.com>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, quic_chennak@quicinc.com, stable@kernel.org
From: Jianping Li <jianping.li@oss.qualcomm.com>
In-Reply-To: <2026052211-pavilion-compost-5fcd@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 9Uqb6yUFDvTYokf4yfty23_BfdyRtwN9
X-Authority-Analysis: v=2.4 cv=Fto1OWrq c=1 sm=1 tr=0 ts=6a13c26e cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=nYJ9tK4vUQEl1fWjGX8A:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-ORIG-GUID: 9Uqb6yUFDvTYokf4yfty23_BfdyRtwN9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI1MDAzMCBTYWx0ZWRfX9po/NWtwmAJ1
 7ckthqTGZ0X91/T6Jo7Vq6ykZbf6zTuMgU7smY7ldCxoYB8cTowbMHOdxBk2ikW7IpCKs239GJT
 P8ZhdB3xp2LYPNYwon2TiL0Btc8aZximtse/H1C6P6tkh9OFny7rLMOki5SxAOwzfHsOhyh0ymu
 J85BOPjFPrBWA75glApN7HOJyx7ykZs9+viF0rzgKAt8CfwbH15c0V6dA19kt5pW/A7M4OTs07e
 8PxGIWJqsXrJXwohg3p5sLrWY6Q9F5vli126YllQCM0a1pdlnq4/kdWIc1tXqPxPH3QV1xv7h6m
 dZjoowsc0bZpIER5DJvwcbgouV0SlA8JjkBxkbXkuSPqrdjSD0pd7B8ChPCleLWbhYCd1Xpnj8q
 CgzfbeQzz1th6wtL4Uj2Hi+//BD2dyshBMy/NSOER+/IRgIT4lFrvj1gTitI+8b7/4QNDT4+hoH
 XZhmC0RW+KZYIiSC+Hg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-25_01,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 malwarescore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 spamscore=0 clxscore=1015 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605250030
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


On 5/22/2026 3:03 PM, Greg KH wrote:
> On Fri, May 22, 2026 at 02:55:29PM +0800, Jianping Li wrote:
>> On 5/15/2026 9:36 PM, Dmitry Baryshkov wrote:
>>> On Fri, May 15, 2026 at 08:42:14PM +0800, Jianping Li wrote:
>>>> From: Ekansh Gupta<ekansh.gupta@oss.qualcomm.com>
>>>>
>>>> fastrpc_req_munmap_impl() is called to unmap any buffer. The buffer is
>>>> getting removed from the list after it is unmapped from DSP. This can
>>>> create potential race conditions if any other thread removes the entry
>>>> from list while unmap operation is ongoing. Remove the entry before
>>> How can it remove the entry from the list?
>> Multiple threads sharing the same file descriptor may invoke unmap concurrently.
> multiple threads sharing the same file descriptor is a horrible
> userspace bug.  If you do that, you get what you deserve :)
>
> thanks,
>
> greg k-h

I agree that concurrent unmap on the same buffer from multiple threads
is a userspace bug.

However, the fastrpc driver is exposed via ioctl, and any userspace
(including any random apk) can map directly and then call multiple unmap.

This patch is not intended to support incorrect userspace usage,
but to ensure that the driver remains robust against invalid or
racy inputs.

Thanks,
Jianping.

