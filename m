Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E61A606A325
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 04:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=bF60muIA;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=eoUsWjUg
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9556810E2EA;
	Tue, 10 Nov 2026 04:15:07 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CE89810E2EA
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 04:14:52 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AA4A7Hh2297920
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 04:14:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 OQIhJ9P2aVCPhaAWlXFblplRpy5ISGBvZif7bpHO6/E=; b=bF60muIAYY2AUBiX
 Z054O+oM5cpZ10NEt7uTrlZVJ4KFHnWLK4vZmluDrOhBPLd50fNTLTkvR5EGB5p5
 TOtBoHR9j1WGJXXSSCF4FqgJ24lXnXbCqioSV8+Xiaa39mhfmdHB4dTR+HevInDU
 PjU8RW+X+AaqMS7Y9TxwDSQ7/bQ1xzBTTP/G0581aFHwJuE6hGnLcZBKip41eEMk
 0RHONkWvjJ9ys1RXtvS3t/6JufItHjJIhgp/MTATZAij9bmEpMG4bd1Yolb3LaOu
 +qO3P4yQ0TLMNcAnpEkRAE/qGe9bwPb8jKOpZwY6LMCle8qWCF5rZecg9gMZJ26H
 DOmpYg==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hu6x2mvvr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 04:14:51 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2ed276af91dso27437355ad.3
 for <dri-devel@lists.freedesktop.org>; Mon, 09 Nov 2026 20:14:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794284091; x=1794888891;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=OQIhJ9P2aVCPhaAWlXFblplRpy5ISGBvZif7bpHO6/E=;
 b=eoUsWjUgbJwgDZGWjlyfH9UF1ByzJpcJoIatvLtEo/jiBwMicKlBB28I1T0D/sV5Jz
 JTDYLZ/bJ6JJKZdBT015h9Q7HqfyOxMm0hPt0btiuDNikVyawYomglNvjmscXVoNyepG
 V4l92GH51botBKYby3kxppVXy7niRTtKw3f4iI0kvumr0Lpc+dJaAOZW4bRaNbX1Navl
 Ub0FhXse+xEz+lLxtgbuogklc+QVjI6vZFpPKOO1m0Pwty1UYmYbUL+2jv5kt0xcjyT6
 OI9uGUUNBWiMDQuVoUPLDsF+Jvz5sVG7v1gt7BPwkQ0thePz9LckHHlcFari0PxXfG86
 svgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794284091; x=1794888891;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=OQIhJ9P2aVCPhaAWlXFblplRpy5ISGBvZif7bpHO6/E=;
 b=KEuf4sOOe942+knUhqFrYemd6CZAHo35dTAwFYAy6O8ujhRvl4hVzMgf6D7F9YKMmW
 xCUhFHH0oNy6l6Kbt8e1q9BATwfgOn1L7ZlKROjYsEBTmQkk74jFJZE4FHP7vAKPanzm
 o/X+QE/UDiGraWW5Crx+nB34BHimfVGnsSYR49IqdQXbTKozFtKLg/v3X7x/CrqP2fc9
 DOPn1q8n07NJ5hC5HDOYubfw6g2aQbzvTk18LOInfnDnWdk0mGnI/hME9WW+bwky1Wiq
 ZDvqRxWsRsRZtXH5s0zA16Q8CqqXIM+vu3lexMUv45yF8vVUGgj0AuGH4wEIzHqXJftA
 +Z3w==
X-Forwarded-Encrypted: i=1;
 AL+hErEyoBV+5YpBs3lq4StG5oyBgr/NjmOWEcb0pdrU8dvsAQVspsKW57viCKzyLc9oR8dgwcRY681UfKA=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+UUjfwPr7Juua8uUArIE3X4ndfW0bDUiHkfCrivxAi8RlcRjPQ
 +lCRjSEZIi4J0jza3iIrqZz/HEow8V/NafyK6yJFy7wTa64hcgenha0tshRb5k8Gd4heYYjKnFc
 GLF6tSt+ymojTnio+OVBVyhpEG8NrBop9J3G7YTWtmV2ztAFzwotVPY0hVCArPeCZuqx1gww=
X-Gm-Gg: AYBFou29qgZtTwgdPH8Of3YS1EVYZbDbdlx3UUjXGx4ePZHjUfwb+wRyQnJtq6rcQMI
 9OrbTn2CcdYVt4BXM2+oaA2gv6HdG08LoN22scq5mT6mDaMLovINp4p0eKkuy0XKOF6zdnnbJtk
 HpHfbzJ10O4O159I0T5SMEBw+HNsTxYNMMcdpmKBLGeo00c5iCB04e20+EN/nBkUqq60xxGX+PG
 RQCHMv2/AvHSMEFeVUPCu65snQIO+Fefz2aXt17cJFXIgF2LRdiluXH8pWDq8rUW8kyyyUZV5pk
 TliEPKlxjirzipgqau1aAw7OUTXGcZPwYOnOgNrK/fgf1fRTLBGH7GpIbco73fGtMM56CxHTF/X
 R+o4GLGEgb8sx+QODaKlj8QophGadToVi1fmwArjwySEwpOSLeajt3CtF79rptMh8JHGkRIb8c+
 nB
X-Received: by 2002:a17:902:cf12:b0:2ed:cab:e973 with SMTP id
 d9443c01a7336-2edb912b6a5mr12936515ad.13.1794284090798; 
 Mon, 09 Nov 2026 20:14:50 -0800 (PST)
X-Received: by 2002:a17:902:cf12:b0:2ed:cab:e973 with SMTP id
 d9443c01a7336-2edb912b6a5mr12936305ad.13.1794284090286; 
 Mon, 09 Nov 2026 20:14:50 -0800 (PST)
Received: from [10.64.69.173] ([114.94.8.21]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2edb6d4d838sm4208715ad.12.2026.11.09.20.14.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Nov 2026 20:14:49 -0800 (PST)
Message-ID: <f54522fe-064f-455b-ba13-bf084576c647@oss.qualcomm.com>
Date: Tue, 10 Nov 2026 12:14:45 +0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 00/35] drm/msm/dp: Add MST support for MSM chipsets
To: Robert Meijers <linux@robert.meijers.dev>
Cc: abhinav.kumar@linux.dev, airlied@gmail.com,
 dmitry.baryshkov@oss.qualcomm.com, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, jesszhan0024@gmail.com,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 lumag@kernel.org, marijn.suijten@somainline.org,
 quic_abhinavk@quicinc.com, robin.clark@oss.qualcomm.com,
 sean@poorly.run, simona@ffwll.ch, stable@vger.kernel.org
References: <20260929-msm-dp-mst-v7-0-4b81473185e7@oss.qualcomm.com>
 <c329cd0a-1396-4a71-a0cb-6921427f7699@robert.meijers.dev>
Content-Language: en-US
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
In-Reply-To: <c329cd0a-1396-4a71-a0cb-6921427f7699@robert.meijers.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=TMjQ2Fla c=1 sm=1 tr=0 ts=6af29a3b cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=dRm9NI7_ec0In7u_rNMA:9 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEwMDAxNiBTYWx0ZWRfXxBCksDUZDhyA
 22Jw3DRZpaMWWYmalRJqobABYCsKJpdN2t/gzmetE+vKNIjJVAjFDamEpo7ShV5CYB6f0H7I1Ve
 wC3szkdtvQrMZA38gZHnq9Kdktedobu7edh9jE89fwXOYsWrtZEd0QorzmjkFIlM7Ew3cHKak4h
 4h5/UR3BQLC8tL7zimqrAkoLXu5RcQevws26wuGLQtDAx5xSUMjEwQ4Z7AIW80MSdDZGZKKBI3c
 HXwCjYsFVlaVdd+Gd2sO0xqjQDCIoRY60BbFRgbeQAAZ3x8ps53r6m88wFsSVpIUv5yoFSwcz9d
 Nhj9l1AoaIyisGU7QwGfIlxNruY6vhxdT7VMFm9oGGZCcD9M8xIdiRJiSXGHTnj90YsehR1lnSc
 DoUW+r6VeDdXl75JLAw7oRC7mPnLqosrOSwOwR/DarUXu98NiPVPT1Q3g36tNrTaPIlODxj1FKe
 oN4kj9A4rdCLurWKuwg==
X-Proofpoint-GUID: 01RIbFMYhB1MQJ3QU4UJyBVYxnrCtXBO
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEwMDAxNiBTYWx0ZWRfX3l1axdzpKYTn
 2751a2tq85SKc5+hVph3X6A2KS8IDRFbuhe+fuSE0vwbb8uXQqsDMnO/eNzA3iiv7FzSNXIgbK9
 KYB8eA+BpoHwRtnV+7GWYOJsH2G8DmM=
X-Proofpoint-ORIG-GUID: 01RIbFMYhB1MQJ3QU4UJyBVYxnrCtXBO
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



On 10/28/2026 5:04 AM, Robert Meijers wrote:
> Hi,
> 
> ((Sorry, re-sending because the first was rejected for not being plain 
> text))
> (First up this is the first time I'm participating on a mailing list,
> so sorry in advance if I'm doing something wrong).
> 
>> Add support for Multi-stream transport for MSM chipsets that allow > a 
>> single instance of DP controller to send multiple streams. > > 
> This series has been validated on sa8775p ride platform using multiple > 
> MST dongles and also daisy chain method on both DP0 and DP1 upto 1080P. 
>  > > With 4x4K monitors, due to lack of layer mixers that combination 
> will > not > work but this can be supported as well after some rework on 
> the DPU > side. > > In addition, SST was re-validated with all these 
> changes to ensure > there > were no regressions.
> I have applied this patch series onto a near mainline 7.3 tree for the
> Xiaomi Pad 6s Pro ("Sheng"), with SM8550. But with these patches
> applied I don't have working audio, over USB-C to my (DisplayPort)
> monitor, anymore. If I disable MST support on the monitor audio works
> again. Debugging (using AI) reveals that the DP0 Jack is not reported as
> connected anymore when connected to the monitor, with these patches
> applied and MST enabled on the monitor. As shown, for example, by
> amixer:
> 
> $ amixer -c 0 contents | grep -i -A8 -B3 -E 'hdmi|displayport|jack'
> numid=208,iface=CARD,name='DP0 Jack'
> ; type=BOOLEAN,access=r-------,values=1
> : values=off
> 
> With MST on the monitor disabled this outputs "values=on". The same is
> also reflected by "pactl list cards" and "pactl list sinks" where
> HDMI/DisplayPort is reported as "not available" with MST enabled (and
> "available" when disabling MST).
> 
> (Again, suggested by AI) I also checked the ELD, which in both
> cases (MST on and off on the monitor) is identical, including audio
> information (like "speakers [0x1] FL/FR"). (Also, audio works both using
> an AMD and an Intel based laptop, in which case I can also choose
> whether to use "HDMI" or "HDMI 2" to switch audio output between two
> monitors, in daisy chain).
> 
> So my foremost question is: should audio be supported in case of MST,
> after applying these patches? Or is this possibly out of scope?
> 
  Not supported yet. Audio is only wired up on the SST bridge, and the 
MST connectors don't register an audio device at all. Once MST is active 
the SST bridge reports disconnected on purpose, so the jack never comes 
up. Nothing wrong with your tree.
> For clarity I would also like to note that without these patches
> applied audio over DP does work as well, irrespective of MST being
> on or off on the monitor (obviously always running as SST because of
> missing kernel support). Which would make me believe that no audio
> support in the same setup might be considered a regression?
> 
> Note that I do understand that me running a forked kernel on a
> (by upstream) unsupported device might also lead to issues or require
> changes for the fork. And that if audio does work with MST then this is
> something the maintainers of the fork should, most likely, fix. But
> from the cover letter and commit messages it is unclear to me whether
> audio support should work and/or has been tested when MST is in use.
> 
> Kind regards,
> Robert
> 

