Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DF4160A2600
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 04:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=AwD0zJSj;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=DwfT/BSq
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 836C010E8EF;
	Tue, 10 Nov 2026 04:14:57 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D02B810ED8A
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 04:14:46 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AA49wNg2297600
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 04:14:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 U3qlC+dXK+CpAmoGXqDZjbSPLC+XRHEjZb4i4RRbB8w=; b=AwD0zJSjZ2kNkWJN
 ccpRP8CVoDMEniLAHBxGHAmBLezgXrJ5C8Q5JRnrHagwgwnFSXcCv5U8J3RgpC0B
 bX5g0KkkqqSyJRTvxU20DRDK+KDb54uvDkbNkJ1+vvunYK7LQiNrWXpUBZ9MiCw4
 ZHfada8u6hl1SQUvF1AxcbmKEORYo/yJYKYKR9B684WSYI5oc4xWz2Iw76SJ0Pw5
 bANkRf/bNp0N4uNNrhIbGuEveq2ElJKcF7TQzoa0EMzaO7EddzQMASOSzRiYvI64
 PP/Ef0TjHeP6drxR8kZcGM0kOc5GTLXjqWcdQ45k7ds8cLGBNX2IExW1TAL1GqcH
 dJ7qQg==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hu6x2mvvc-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 04:14:45 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2ed283cb5b9so9048665ad.1
 for <dri-devel@lists.freedesktop.org>; Mon, 09 Nov 2026 20:14:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794284085; x=1794888885;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=U3qlC+dXK+CpAmoGXqDZjbSPLC+XRHEjZb4i4RRbB8w=;
 b=DwfT/BSq+uC4ve6FJmz2s2O2BwO66JcPn4R463wW82+Bu1L1VJIrGSIoVaav0gTQh5
 kmHqwS4U5955YHdw9aQ7IPtYuL/S+1HFr5/RZyI9J7U88nNX6OXbJoG5l1jyr4Ez11Mc
 fMQ+qXPPWwgdbvIpW0UT5+JRLPHQGHiZ4RRJkrenY84tiIursY3XMVtgnU7uE+d6idh8
 6rsB02u/ZuGGWzlfd+Iv/CXaXNJybUlARZdTiDkXG3l0Mwx3nlQBVUWUGmT2CbtsRicd
 KX3YKP9v5cnmvJzRcqfsop/YGf7WlIkWcR06xT6lFPUszC3qZ+Kobh+remeoTkhg+6zK
 o1xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794284085; x=1794888885;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=U3qlC+dXK+CpAmoGXqDZjbSPLC+XRHEjZb4i4RRbB8w=;
 b=k5NGKVR1Bdb9HtuMrgmH80bTvCH+IcacwDn02GUkhKb+45ywUWAsCuya05xvaYuUZm
 8tSO6tVugdintAuUN3tjoUXjLWHn9NTW6kR88qn5nbjnx3QRKs/E/j1KsuF4HCtkdXyt
 0jzZN2OqiOjkjt+7UK3FSgo2Cv+Qab7MI+iz56sbCjRr7DoAJFzxKMEWwYqViC+hoWvc
 CnuJ0ifwkzzyIt/BbDEqdsXcPd0WX13uzns8Z/S97KH/gi0ybTSzEncrun2cnGb9whYt
 NJXckAS6bpO72mTB+qAjn7jMz+XhtSEPs3B1n/MPtT06Pt4LmPjmcOSrpJvPnDB7Dtk4
 a7Zw==
X-Forwarded-Encrypted: i=1;
 AL+hErFROMw9/ee4gUBx+CzJsMMHLJwL7Ubt6XY3EHLJ8dR7IsVIwI8tI/A/QWNN/yVFfmvLbj9LpbaW+qw=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/6gFu4tTqcljCv5LV4fsAbysfBB8ykbvubqOQVNP8xXnRMyFeh
 fkVq0Y5tiugOfCnAyJnGOmg681vRSJ+kXm7I8Hj3tJ1LglPezhSrpVrq+Ofp7kfkoVmVJaeiVvf
 1cwGfKCI5hAAdwvAgVLtg7lxO1H/q0MoR5+RiBordx1rNAwXYYw/l2Gup5JLYI0Me9SujElI=
X-Gm-Gg: AYBFou1uswhKv0pBpWjnp0v5LUSL4lYoPXM2YmAO1vSQUONkT407CB51CG0MiQEFQ42
 L4y2XLa5L1ek5PAsEBPf31kjEgy20wG6DY3DRVxJ3o4cuUjcqtv8sMtjwuqie6O1h1SyuY9EGKg
 N9wwfQaIA9xjUGkGN7VFrDk1/vKQwhVfMoMZKgCCnbUKdd0ctGJKn8dvTkQ2p/EBGrW65Hmx7KI
 uPlC+afFFmEftEPpoFa5XV7pe7gFDpjbFm7wkKXfM8PZ/LV7q1C6BE2xLKjEU/Ukkp7w7sOBwmN
 62o6XrzrnTvvW0Rvsmoo77jrh3uq3IUM8DYsnn8yoxg972KnCO3fkTWENgXhdqWkDeIE+DmBSyX
 gwL35w/tPpBzo0mSr6rakfaEEyAZ8vtEj1Q5EU9PBB/vvP59Vq3ZAg9FDDS83F/SXW5yr7n7Wif
 gG
X-Received: by 2002:a17:903:1850:b0:2ea:10e9:7db6 with SMTP id
 d9443c01a7336-2edb6e6d449mr12045005ad.3.1794284084684; 
 Mon, 09 Nov 2026 20:14:44 -0800 (PST)
X-Received: by 2002:a17:903:1850:b0:2ea:10e9:7db6 with SMTP id
 d9443c01a7336-2edb6e6d449mr12044695ad.3.1794284084156; 
 Mon, 09 Nov 2026 20:14:44 -0800 (PST)
Received: from [10.64.69.173] ([114.94.8.21]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2edb6d4d838sm4208715ad.12.2026.11.09.20.14.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Nov 2026 20:14:43 -0800 (PST)
Message-ID: <7c80e1ac-e4ed-40cb-b562-cc2a27e6bc3f@oss.qualcomm.com>
Date: Tue, 10 Nov 2026 12:14:37 +0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 00/35] drm/msm/dp: Add MST support for MSM chipsets
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Robert Meijers <linux@robert.meijers.dev>
Cc: abhinav.kumar@linux.dev, airlied@gmail.com,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 jesszhan0024@gmail.com, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, lumag@kernel.org,
 marijn.suijten@somainline.org, quic_abhinavk@quicinc.com,
 robin.clark@oss.qualcomm.com, sean@poorly.run, simona@ffwll.ch,
 stable@vger.kernel.org
References: <20260929-msm-dp-mst-v7-0-4b81473185e7@oss.qualcomm.com>
 <c329cd0a-1396-4a71-a0cb-6921427f7699@robert.meijers.dev>
 <vr7xot6mfkdjou3wy2ni33ctban7goaqsr3xuw73przuefaupp@6lexppuvjypx>
Content-Language: en-US
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
In-Reply-To: <vr7xot6mfkdjou3wy2ni33ctban7goaqsr3xuw73przuefaupp@6lexppuvjypx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=TMjQ2Fla c=1 sm=1 tr=0 ts=6af29a35 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=m0oZJYypAzi8eX9yTqQA:9 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEwMDAxNiBTYWx0ZWRfX/ZIXFHV0AbWU
 Dqz8tjYLK3HOn6jh6zJnmhWVDT0Umi8ipjzzrLk02wk2o4+FtR+rBYtR6d7LJjEp/RTectySCFv
 n5H1Ba6t7Ys5eS70taZ4XDmHfj3icDCvl1N6w75+zdopFQ7H0kwF9YhbMNQdQcsOvKmqzuEH4I1
 JcDFbCgj7rIQRpaZ9fCfhnMu6m3YNQXcXOthpgsgHzO9A35ier+RIxNLKuB7KRIzgb4Lg3o7t6u
 1mLuAeFWEkLForLesSnzBbb2+khHUY2AvjepynpRcPbPmipVKuTYM3js5pjoGysB+9sBQld3kNC
 hr+Nq1jAxs8ojmCzwGpooAQ8wcgn6jaBAxpJZOCIdLVqCijtKM7s+pgUjMWtCTVBg1qrlI7ssuy
 Bn7ipCCi+y0YODXqwUz2axaG3D0q/uhieiSWbIvPuEGcwJQQ6F9Cm9a9Ji2v+78F4qUJDtll3Dj
 yOjZh9q4oBqWmJxenSQ==
X-Proofpoint-GUID: bcnTZei3yh5v7f3-iVgrBmwcOcJ50dUH
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEwMDAxNiBTYWx0ZWRfXyB3+mRcXThEz
 TceOAKb0jq3pfUkhz7w6QIeN/svwFwE3ACHdfL5YdtzzK8VL1K2Bu/u4c7gx1q31EjePaP0snFL
 hxNTKqmVqoyBCeyZiWtjIUR21BHazhY=
X-Proofpoint-ORIG-GUID: bcnTZei3yh5v7f3-iVgrBmwcOcJ50dUH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-10_02,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015 malwarescore=0
 phishscore=0 priorityscore=1501 spamscore=0 bulkscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611100016
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 11/9/2026 3:25 AM, Dmitry Baryshkov wrote:
> On Tue, Oct 27, 2026 at 10:04:54PM +0100, Robert Meijers wrote:
>> Hi,
>>
>> ((Sorry, re-sending because the first was rejected for not being plain
>> text))
>> (First up this is the first time I'm participating on a mailing list,
>> so sorry in advance if I'm doing something wrong).
>>
>>> Add support for Multi-stream transport for MSM chipsets that allow > a
>>> single instance of DP controller to send multiple streams. > >
>> This series has been validated on sa8775p ride platform using multiple > MST
>> dongles and also daisy chain method on both DP0 and DP1 upto 1080P. > > With
>> 4x4K monitors, due to lack of layer mixers that combination will > not >
>> work but this can be supported as well after some rework on the DPU > side.
>>>> In addition, SST was re-validated with all these changes to ensure >
>> there > were no regressions.
>> I have applied this patch series onto a near mainline 7.3 tree for the
>> Xiaomi Pad 6s Pro ("Sheng"), with SM8550. But with these patches
>> applied I don't have working audio, over USB-C to my (DisplayPort)
>> monitor, anymore. If I disable MST support on the monitor audio works
>> again. Debugging (using AI) reveals that the DP0 Jack is not reported as
>> connected anymore when connected to the monitor, with these patches
>> applied and MST enabled on the monitor. As shown, for example, by
>> amixer:
>>
>> $ amixer -c 0 contents | grep -i -A8 -B3 -E 'hdmi|displayport|jack'
>> numid=208,iface=CARD,name='DP0 Jack'
>> ; type=BOOLEAN,access=r-------,values=1
>> : values=off
>>
>> With MST on the monitor disabled this outputs "values=on". The same is
>> also reflected by "pactl list cards" and "pactl list sinks" where
>> HDMI/DisplayPort is reported as "not available" with MST enabled (and
>> "available" when disabling MST).
>>
>> (Again, suggested by AI) I also checked the ELD, which in both
>> cases (MST on and off on the monitor) is identical, including audio
>> information (like "speakers [0x1] FL/FR"). (Also, audio works both using
>> an AMD and an Intel based laptop, in which case I can also choose
>> whether to use "HDMI" or "HDMI 2" to switch audio output between two
>> monitors, in daisy chain).
>>
>> So my foremost question is: should audio be supported in case of MST,
>> after applying these patches? Or is this possibly out of scope?
> 
> I'd say, it was out of scope for now.
> 
>> For clarity I would also like to note that without these patches
>> applied audio over DP does work as well, irrespective of MST being
>> on or off on the monitor (obviously always running as SST because of
>> missing kernel support). Which would make me believe that no audio
>> support in the same setup might be considered a regression?
> 
> Technically you are right, it is a regression in your case.
> 
> Yongxing, how difficult would it be to support audio over the MST?
> 
I don't think it should be too difficult. It would mainly involve 
programming some audio-related registers for each MST stream. But I 
haven't actually tried it yet.
>>
>> Note that I do understand that me running a forked kernel on a
>> (by upstream) unsupported device might also lead to issues or require
>> changes for the fork. And that if audio does work with MST then this is
>> something the maintainers of the fork should, most likely, fix. But
>> from the cover letter and commit messages it is unclear to me whether
>> audio support should work and/or has been tested when MST is in use.
>>
>> Kind regards,
>> Robert
>>
> 

