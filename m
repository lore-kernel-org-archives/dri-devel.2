Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38AC8CD5BC8
	for <dri-devel@archiver.kernel.org>; Mon, 25 May 2026 09:35:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 96F7D10E0B9;
	Mon, 25 May 2026 09:35:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Ig9hIB2S";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MfwUHVwS";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6FB8010E0B9
 for <dri-devel@lists.freedesktop.org>; Mon, 25 May 2026 09:35:45 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64P7F6PE3132975
 for <dri-devel@lists.freedesktop.org>; Mon, 25 May 2026 09:35:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=+jiBA7doX9rURskYnz5ej3I9
 j5hNMPLyAxStOrC2T/U=; b=Ig9hIB2SbuMDIfLikSuKvKm8JayiTCS+DwGvvLPi
 FAEecXskNhIaaGe4xc16cIfgfUq1ZQ0N7UVxoXIQz8+Gdt0PbUVxgEEo2dfv2FW/
 46cr/rfy8bsW8nJzk3PNVLIvEg3vxpwjM5qnahdgXPZ/hG/xqyG9HIsmSbhOpyBM
 eRv3bh+RZ8leedyP7n+NeF58zIiS5w0ZCjjEBT6/vGDh+Z8M3idOj8Y4D8DbAplq
 4edXFbiREj+TrhvvdPBHfA7jFT317OZT3n+o6cXI83WRov2CWkYa5LbZvyvNXNQj
 jPcAn2GjJKRAQlTmUGAS+jxbx1Z53UKFu4Ebe8736Vj2Ag==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eb36t67jj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 25 May 2026 09:35:44 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-82fa2165c3eso5953732b3a.0
 for <dri-devel@lists.freedesktop.org>; Mon, 25 May 2026 02:35:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779701744; cv=none;
 d=google.com; s=arc-20240605;
 b=dwfL0QUaECuQDDKGFykPi/ngWxRz5qmMnF6VCcZaEc5Mglq9OYtG/d1aCjs+yCmJPb
 SDG24aSdKQrj8SywJmrq9As9amhAWgzaph11AjDMeAyIv6GhGOX/BDTu8mUSUZC4Klyf
 GVW0tTKtTqm0PFVRi30VN0xdYg2VATU6f+ok8H+yfXLtinQcch2Ov+DEXdOtz6TV9N7P
 ik3wxoVvb9nlTroadlNuwiO0sG5Wo/gLlYAiUfmjM94QZW1AzOT115M6tboYP7miiLej
 JAumpn4LHGm5kEUPx8Wvbg6dV85J/OBvHBieKU1Wo1MLReURszm77Zhk3xH4Ja01nZCu
 GhGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=+jiBA7doX9rURskYnz5ej3I9j5hNMPLyAxStOrC2T/U=;
 fh=xgsUSuj0r8NZKv85IYhI9nxKt65mKgmKlQT8S/4MhKQ=;
 b=IIdL/i0wOg6a7FCNMlesgrC4bRm5b9JrP4DtwNZp4Z/J3G7rQhhyhVy2JMXd7hAMwE
 w8WgBqjTcNFP9r6kpB9fgviJaYx5iMvh+B2mzWRjQf6UrRpwtDBvtSllLV4m7A4aelgh
 0N5P9p6qGkBiECK7eAVPnB+RQYrENea2Mi0FWpB7Kbv/W0Q0S9C/E422ScdSzC9B+ROp
 vIbrqLUCDZ9Z1dPCGyPBvIZoF8vavHSNUY2o36hOLvhVRFBqmMGm4BfnoSs1RRdT8ZnE
 RrHVer3+uvYw4n5XxXNnPma+BzVBNYDc6tx6ZnVAMvJav9LDBIXNjZ/eoYeWZQbd2dqA
 Vs0A==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779701744; x=1780306544;
 darn=lists.freedesktop.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=+jiBA7doX9rURskYnz5ej3I9j5hNMPLyAxStOrC2T/U=;
 b=MfwUHVwSQ1fiFlwdjNNbwJvWz1NXxa8Vc5JAo/Xm5ui1fXbF7wRVF+ZYcZB4HMWURU
 UJwG/OqXK1dor9MXOnCtIFAVNJ1iGWHRS5RJblHPKvQiqmHbE2qziYPyWdf61oUBRdqV
 aRlO9+MQpCmA9M4A4vpO7nHdyeONy69EXHn73KRVzfEyUsk82H95FK44WbruLlkKfg6E
 65log/S9CjWVCwco18pkr2ixY8XW5tL6dmVyYKn6hIvwzoqskQV+LSyLeQhSxJhvJpoT
 gTSAE8yb54K9ZduA6HRTjsxJiQmPIWTSiXGIecpLt17Y7wrncry8Mc/sUb4Q4I9epyqg
 M4cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779701744; x=1780306544;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+jiBA7doX9rURskYnz5ej3I9j5hNMPLyAxStOrC2T/U=;
 b=SFZLH2yBKeTJyngkc0fPZUFa3AhRmzFKSZdvg1Y1a4kXpNv6vENSzl5urIvmGK0P4J
 qZag1YNDbOMi7CvyAdApYaRXaUabu2aUYwgUm/fvfrTb37ZYuaFBWAF1NGAOa+yzgAtt
 R62InOkLfho5tpV9mV0ZIvmjGUxd1w0DhBveKo/pSM8Gmcux5oOPzDKFz0TsJXnH0XCF
 2AM8GObuZTrl2W5MrafdrUc+s06s+NvV2ye+7sfFNZHqd0AWtaUQqAxsKH3hTW2B9R9l
 l7rlECuvirfX6jVz0ikOlR0mEtDAW9Dm8IrAsyzZEr2NOdrkr2QJLZ8ycc3iXdHRPsg1
 b+cA==
X-Forwarded-Encrypted: i=1;
 AFNElJ83vAGVXE13Q/8FNW8IEc9MXnjEoUbYZ2NS92uEVbAEEPIVnkHAgGHn/UJQpK6Yk+DMUChZnZA50LM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyWgfRsipz6cnBkaK1sR9Ir96FLNQxzGb/OiQsxqg8YuUt5lcy5
 c34/WoMj2dHj5xVP9aUdzNyU8g9oliDsTI1fA8DVN9AftrbYcHKaYmsXk3R1mcxKIB+uh9IJo+G
 tyCfIfcXLDJKFWeAedboGB1hq8SYyt7NXKBV4iPEtvSMHKNek0dlBNUYg7GayOiGazmNBaYhNMc
 yGWd74hNMKD1DoeQmV98VTJr9o9i0ZewcSPmCQi9i41i52Gw==
X-Gm-Gg: Acq92OF3xkb//aEqtHxQfoDnAxvZwZ2XQet7H2lYWP7Ej1HV/p4qE5641PAsq/Z1lDh
 f8zWcSZ7OFoHZVklRUhLoKRYQbqUDRksSgmbTEYHhcfHHJOgQNDuSHvpP1Y+1VT3MHiBN9APkml
 O5EDZhXGNvS7ooKTFUjLXJvuvFjcLyNdSLri+j9iXGzHX4N4MU+nfO5443nD17rlldynE6KEWQ3
 +hT
X-Received: by 2002:a05:6a00:140e:b0:83a:4846:90b0 with SMTP id
 d2e1a72fcca58-8415f3c6635mr13228153b3a.46.1779701744120; 
 Mon, 25 May 2026 02:35:44 -0700 (PDT)
X-Received: by 2002:a05:6a00:140e:b0:83a:4846:90b0 with SMTP id
 d2e1a72fcca58-8415f3c6635mr13228122b3a.46.1779701743493; Mon, 25 May 2026
 02:35:43 -0700 (PDT)
MIME-Version: 1.0
References: <20260515124217.20723-1-jianping.li@oss.qualcomm.com>
 <20260515124217.20723-3-jianping.li@oss.qualcomm.com>
 <xnkycubizpoe4rmhc3jt36ulx2fb3tubjybu3djovafkqqttmc@o6vw2so5ctxr>
 <37146a3a-b18f-40f1-b95b-0ac19bf6c07a@oss.qualcomm.com>
 <lvfwkplrktjldbvn3j3jqh7ds25prx723at5t5oobsvhgolngs@pme6jiac5xdg>
 <85c2bfd1-8e69-47e4-a360-10a2655bd43f@oss.qualcomm.com>
In-Reply-To: <85c2bfd1-8e69-47e4-a360-10a2655bd43f@oss.qualcomm.com>
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Mon, 25 May 2026 11:35:31 +0200
X-Gm-Features: AVHnY4LlU98vParczGXOu16cCLc3xW3kpnRgy1EhIULshOedjsWgR9G244QanDo
Message-ID: <CAO9ioeUgeo-MiP7pNY16wL9d7LKEi7PR7pJtH=1hMg-mnMSOPQ@mail.gmail.com>
Subject: Re: [PATCH v5 2/5] misc: fastrpc: Remove buffer from list prior to
 unmap operation
To: Jianping Li <jianping.li@oss.qualcomm.com>
Cc: amahesh@qti.qualcomm.com, arnd@arndb.de,
 Greg KH <gregkh@linuxfoundation.org>, abelvesa@kernel.org,
 jorge.ramirez-ortiz@linaro.org,
 Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, quic_chennak@quicinc.com, stable@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Proofpoint-GUID: o1HlRXT73eSd2NI7QOuyr62qSlwe0cQV
X-Authority-Analysis: v=2.4 cv=Fto1OWrq c=1 sm=1 tr=0 ts=6a1417f0 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8 a=4YpZvLgTicFLWUaLNysA:9
 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-ORIG-GUID: o1HlRXT73eSd2NI7QOuyr62qSlwe0cQV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI1MDA5NyBTYWx0ZWRfXy0kEDc3Z9ajX
 VFFNGZI+F9+IQ97CgJgQmd/1MnU9jLjzlK6vqto1gDxDxdO+5Ufq/8eQHm7zvNRqgmTpymoA52i
 wdZZCA0yrfZACVZ7fCoK34Dzq5rpixh8/mkbxO2Wx42NNAjPo9rPpNSJzFDK3YbE5fmDrjqcKaP
 gYoJ6xB7CshyJ3yg5NaCqgyj/crLWqcQHVCVTWFO2EKD/YTRoHFOLZYtdGM/IYHCwDSSZjftemo
 7/Q563AT7vxnUq5/kxaZiNhTjbxjh9zHrw1Y30WeD0Sm4O4q59qnWBCGPe99rMAk7QXBYnfmYPF
 BGvlTbgtnRoD4Dl40duAbnXTzzl9kuGugw9CCg/BLG7gKdAtQJHbiQosbLMRRPOVZEkpUSpI6Ox
 VnM7mn71kgezEh13tdOtp1pt037NJIvWxyKRIe8xq3kGN0X9uUkbcpJBY/1jtFdd4bI3enXPyeU
 8vHYOAZRaREbHG33Oaw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-25_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 malwarescore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 spamscore=0 clxscore=1015 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605250097
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

On Mon, 25 May 2026 at 11:34, Jianping Li <jianping.li@oss.qualcomm.com> wrote:
>
>
> On 5/25/2026 4:30 PM, Dmitry Baryshkov wrote:
> > On Fri, May 22, 2026 at 02:55:29PM +0800, Jianping Li wrote:
> >> On 5/15/2026 9:36 PM, Dmitry Baryshkov wrote:
> >>> On Fri, May 15, 2026 at 08:42:14PM +0800, Jianping Li wrote:
> >>>> From: Ekansh Gupta<ekansh.gupta@oss.qualcomm.com>
> >>>>
> >>>> fastrpc_req_munmap_impl() is called to unmap any buffer. The buffer is
> >>>> getting removed from the list after it is unmapped from DSP. This can
> >>>> create potential race conditions if any other thread removes the entry
> >>>> from list while unmap operation is ongoing. Remove the entry before
> >>> How can it remove the entry from the list?
> >> Multiple threads sharing the same file descriptor may invoke unmap concurrently.
> > => commit message
> >
> >>>> @@ -1898,7 +1897,14 @@ static int fastrpc_req_munmap(struct fastrpc_user *fl, char __user *argp)
> >>>>                    return -EINVAL;
> >>>>            }
> >>>> -  return fastrpc_req_munmap_impl(fl, buf);
> >>>> +  err = fastrpc_req_munmap_impl(fl, buf);
> >>>> +  if (err) {
> >>>> +          spin_lock(&fl->lock);
> >>>> +          list_add_tail(&buf->node, &fl->mmaps);
> >>>> +          spin_unlock(&fl->lock);
> >>>> +  }
> >>> Is it expected that userspace tries to unmap it again? Or why is it
> >>> being added to the list?
> >> User process can call unmap and fastrpc library won't call the unmap again.
> > In the other email you wrote that the driver can be used by random apps.
> > So... what happens if userspace unmaps it again? What if the userspace
> > _doesn't_ unmap it (although you've just readded it back)?
>
> If the same buf is unmapped again, because it has already been added back to the list, the unmap logic will be executed again.
> If userspace no longer performs unmap, the driver will not unmap it proactively.
> The Fastrpc driver will free up this list during fastrpc user-free.

It will free the list. But what happens with the memory mapping?

>
> >
> >> Fastrpc driver will free up this list during fastrpc user-free.



-- 
With best wishes
Dmitry
