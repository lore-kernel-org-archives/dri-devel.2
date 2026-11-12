Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6E64606A323
	for <dri-devel@archiver.kernel.org>; Thu, 12 Nov 2026 02:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=nlYlPo9Y;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=FrKqWgXQ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DFEF110FF30;
	Thu, 12 Nov 2026 02:21:51 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5C26110EAF8
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 02:21:40 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ABMaFqo3305670
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 02:21:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Rq7GooCIZ7G/d81xEEdoUjPL+7aCqzIfy3ZyVlLQm9c=; b=nlYlPo9YvJkpg/IW
 fz55gQzv0lahwyRwsOUoXxUnlDf7T9g2B+AQBD8thk83ZytRXSZXEyPL4y1mARGN
 Ajm6Q3/2BJB1gQBUbX1GNf619a2K3RoKce1heUyBG+EWsrSxdEZLWT99WZ+VDgWW
 uy6H5km6m3hYDs5Xj88gbkzodviQ0y07Sy922WT0Gg07yYq3p/giNyncoqC6NmGs
 tKVhTmBNQ2BQA5RQysGrwHQ49KrqEI8t8iSqfQSH9Z273CquwuJqfpEvV+K6OciK
 Llede7IsBngZy/unLu5RhXWQ/FMHg2pSLbreb00NOfQLIHPhZoH6bhKw7GHJ9qY3
 XjjsCA==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hvvw0hpq5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 02:21:39 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-3b17b31c3beso1588323a91.2
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 18:21:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794450098; x=1795054898;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Rq7GooCIZ7G/d81xEEdoUjPL+7aCqzIfy3ZyVlLQm9c=;
 b=FrKqWgXQQ0g3Aa6T07YThS0vwo8NHAOz1qSxXf+WxsPFvShrat7HxAVsguoUJDKSSS
 lgtCBmYuEDvqyTCXL8rkwBq428YFpjfeaoKu7EWWXVNfWBkCL273THZW8PM9Q9lJFLIT
 QUxIb5EcOnZeudl38B89hAVsj2tplpp7REFfIOR4YbT5HA3fwx6+K/14Wy45RyILA3BQ
 n+cQExLI5Ipeysm1iR3F8jxeA4ywjr09y0FgGJ47DcT1qGWWWWdOPvfjz5N3Y3vy/3Vr
 G0T1Lz+WjC/IgeigoLhNtv8jo93M+i2x0FqdpigQEDfrFdPpH+f52bJS6/0xx3hES5k7
 IvOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794450098; x=1795054898;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Rq7GooCIZ7G/d81xEEdoUjPL+7aCqzIfy3ZyVlLQm9c=;
 b=dkqNL6/vVeFyxD7ueRo2rKL5Dd1AVjCd5zc5B9PoHlj8/Mrvzz4Q0J9bh2vHTEh1c4
 ll4kcDiPlULZ5tjnDhtIp2uRZ+WsMaHY0hJv+/FLRSoX7kSM6N1zOOa8MbiXM4F/yHfV
 nXmsAPeT4gxQIRaxXGQBk9yZhHhPspQgJgwegDZsie8dZ4LoRb+zfRngUk/GuPbdSaCY
 gtXNU0QemzECaANVpQlddo7v1oQXTUTYnskoNqEE9z1zHWF9Cb2qJN5N2d+rBUrpNRTZ
 qY4FuEiI39yz1dSFfcKjRnSx/IhvMljPq61Im/8LAny753XJUNXaQi96kTA1Ju+ktghB
 rR5g==
X-Forwarded-Encrypted: i=1;
 AL+hErGPLoQtjHQ3hQ+rKgIV5fsBgAuXgwm/FW+5uyQcPwGFgNxM/5gg0fbTZijosXnooQBIZNBlWVQWfF8=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+anAoAcaVVKr70eSNI47ZiE4j5kZMbVhrl9CywuyCBdsdGlozk
 6VjRtk8YLAzEtoM4jibCUMGTlOieDm6DTDjhZ1EShiVB7gdI7sQsBB6wci+npTMW2axsp9ypaIq
 k/Pyc9Vc/vfn7Coh5HKXbd5ExYkKJnwj0ljvwhdKxPNDCrBDnYUzA+jc77q7qedDEMHFiUMQ=
X-Gm-Gg: AYBFou1yu+hCyD7F8yc21rh+YTGXYxDEMeVpUvGDCLY0LfeEVJ6Bjcbci6uF3Spo1Ua
 rQfuUz0GVKekevgmVAM+GsJTos2TWrwph7E8X2F8Nsp3TNFvHO273GAIdsXxQ9eNepfjs1S0Dbp
 HlQbjyf/ZX9QY9iiTqMYgIfRImOoH13FGgyjsMvSyMjlaBv04zl8k11i9Y42fMLtbepjA9/c9wI
 EFIvvnZMV/Y9UK4Ena32LuqfuIjY4D1BBDNE6E4Su2cVnCx/TkPAgzJ3VfqDO4ch/7XJRHgwr0S
 l439jlm0ZQiyty2eKqZFKqTMynFGVDs7Zxwn5qLnSkl6AevTUc7rb0a6APfDa7FFS2cptqOITDh
 rtpQ8Ap94jAiW/Lm08AoY+zpJ/7Wqhr0KbW7aixg13amnjC21KE0jh8GcNYgKEExIYxdpsxUU0j
 WT
X-Received: by 2002:a17:90b:388a:b0:3ac:a993:5b5c with SMTP id
 98e67ed59e1d1-3b182e13d4emr4150524a91.6.1794450098025; 
 Wed, 11 Nov 2026 18:21:38 -0800 (PST)
X-Received: by 2002:a17:90b:388a:b0:3ac:a993:5b5c with SMTP id
 98e67ed59e1d1-3b182e13d4emr4150494a91.6.1794450097226; 
 Wed, 11 Nov 2026 18:21:37 -0800 (PST)
Received: from [10.64.69.173] ([114.94.8.21]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b197c9d7c1sm1880088a91.17.2026.11.11.18.21.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Nov 2026 18:21:36 -0800 (PST)
Message-ID: <fbacc809-7931-4613-ad49-59e74852394f@oss.qualcomm.com>
Date: Thu, 12 Nov 2026 10:21:30 +0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 02/29] drm/msm/dp: add support to send ACT packets for
 MST
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar
 <abhinav.kumar@linux.dev>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jessica Zhang <jesszhan0024@gmail.com>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Abhinav Kumar <quic_abhinavk@quicinc.com>
References: <20261110-msm-dp-mst-v8-0-d040fb33db5f@oss.qualcomm.com>
 <20261110-msm-dp-mst-v8-2-d040fb33db5f@oss.qualcomm.com>
 <ebgbhztbeifcty7tlzwykvwcfrn3bwsktfyy63nu4ocvygnqnm@prggbz5tzmct>
Content-Language: en-US
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
In-Reply-To: <ebgbhztbeifcty7tlzwykvwcfrn3bwsktfyy63nu4ocvygnqnm@prggbz5tzmct>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: QzLvviXeeMPQZFdbhoQY_zCIGLa64ra4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEyMDAwOSBTYWx0ZWRfX8ffuaWTdPn9u
 iJxeqjibvD8u9SRnUEpBBnHhj3u0W2dBQDc8WWixwNod40CN8nZd33lamaBhnzywjVhZYZm2WaT
 RGc1AkI23+T8CoaxevGBkzb82joH3wQdbZBPPTSgCGabuFu9osaLj4vWMvQYVsbQxaTYbnFu/o/
 v5xTZm/Lz2PRKmVOMFbrxXxjfzK+1i6mhVQQf9gmGMFL7D9H7LTEOjRFtjTFSXejTnx9gopeVyK
 wxlUt3oMr6BHbh0mlexlDYBXFetZO6qgt6zhbqOR2lMlhleld/T34AabeFdD7AhSjV/P4/VZ190
 6128GbwWTtVf0gsF5beGZ7nVzR6+wVjlUueEcohZHLYikQ25Kj8W1cy1miJiN9+vIZ3YpkxMjMn
 Q0JyJqHSUM/sDXloUQb/xkHaB0R9kV0xNgZ+9f5Gy0Qf/EvXPZRXkjT92KumbREU8vlxBRA6fal
 34EQn699k9C4lWignOw==
X-Proofpoint-ORIG-GUID: QzLvviXeeMPQZFdbhoQY_zCIGLa64ra4
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEyMDAwOSBTYWx0ZWRfX/LAZhK2W59/2
 RaIouCYgCJu9ce825ZQUMH6sykEyH4tthug7xkEWbrnfgvRf8HM26OU4CkVGgpdtpUwFR2r8+5G
 7W0HFfD+iD79gKHDo8xrCQssr3+e44g=
X-Authority-Analysis: v=2.4 cv=ct8OAF4i c=1 sm=1 tr=0 ts=6af522b3 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=lBWZ1gcxILu1McdKNGgA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-11_06,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 clxscore=1015 phishscore=0 bulkscore=0
 malwarescore=0 impostorscore=0 priorityscore=1501 spamscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611120009
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 11/11/2026 10:41 PM, Dmitry Baryshkov wrote:
> On Tue, Nov 10, 2026 at 12:54:23PM +0800, Yongxing Mou wrote:
>> From: Abhinav Kumar <quic_abhinavk@quicinc.com>
>>
>> Whenever virtual channel slot allocation changes, the DP
>> source must send the action control trigger sequence to notify
>> the sink about the same. This would be applicable during the
>> start and stop of the pixel stream. Add the infrastructure
>> to be able to send ACT packets for the DP controller when
>> operating in MST mode.
>>
>> Add REG_DP_MST_ACT, the ACT trigger register used by this sequence.
>>
>> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
>> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
>> ---
>>   drivers/gpu/drm/msm/dp/dp_ctrl.c    | 44 ++++++++++++++++++++++++++++++++++++-
>>   drivers/gpu/drm/msm/dp/dp_ctrl.h    |  5 ++++-
>>   drivers/gpu/drm/msm/dp/dp_display.c |  3 ++-
>>   drivers/gpu/drm/msm/dp/dp_display.h |  1 +
>>   drivers/gpu/drm/msm/dp/dp_reg.h     |  1 +
>>   5 files changed, 51 insertions(+), 3 deletions(-)
>>
> 
> Is Sashiko comment valid? Otherwise LGTM.
> 
The comment is valid, but the issue was not introduced by this patch. It 
was introduced by "38e4b12149792 drm/msm/dp: move the pixel clock 
control to its own API".

Would you prefer a separate change to fix this issue, or should I fix it 
directly in this patch? If the latter, I’ll try to send the next version 
soon to keep this series moving forward.
