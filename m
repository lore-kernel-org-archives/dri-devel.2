Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5065ECCF2C4
	for <dri-devel@archiver.kernel.org>; Sat, 17 Oct 2026 18:16:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 61E6510E473;
	Sat, 17 Oct 2026 18:16:48 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 90E3910E478
 for <dri-devel@lists.freedesktop.org>; Sat, 17 Oct 2026 18:16:37 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69HGB96s1481956
 for <dri-devel@lists.freedesktop.org>; Sat, 17 Oct 2026 18:16:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 0nRvE4iYzZZkY8FL+vx+dpAmS+CxJcSbG5OBNTwgPiI=; b=S/RfhN82Lm0VO1jb
 QR3BDj/jzII96FvgklOjhpcaYnIKzz+TZGjB/FrJ9Qg8CbqO1mJlf2+WF7+n9G7Z
 rsWIHqkWh5pClwfNbBBjroRiv9XgPMNBVuRQe31DY0q3W14P/t2IBvrPYTA+l3RH
 HJK4KPDZOkd8IOOPpYfr1iGp0WWW06e2Fo6aMPbMF84o6i/ARMvboWObdcvBEykP
 aCC36vwnN94fH97q6TOwsc7148v3IuMKwAeiRrNWBr+IGKSJ/+kj8GsDjXoFSeDS
 I9WBFqSwApaXhOlKWXLsX+zpjFhYTD/AZFuVsVaUoWPp0ABZpAMw3iqYVNHo69eu
 VJIQZA==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hc13usgnk-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 17 Oct 2026 18:16:36 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-341eff9e381so2738777eec.1
 for <dri-devel@lists.freedesktop.org>; Sat, 17 Oct 2026 11:16:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792260995; x=1792865795;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=0nRvE4iYzZZkY8FL+vx+dpAmS+CxJcSbG5OBNTwgPiI=;
 b=AlV+bZOqd7CnnGaL0LcvvsBUJmE9ZXUA6fiX3PfRvAD4bQgoA67P/RMleGkmOpiwBy
 nYgi4oIuETEfcxVn0+5giiyG2tFz0fGOMoUhsIZwl37hBBPnAWUpdsxUKEwkF5zDjQFD
 W+uNCeFEXVmYi1n+A0nrri8moOaLzpDjbnOxb0IsKB5j5Ej1Dhnq+Gk5uyxvIhKQ6ExK
 STEnJDPL3GSYKDLcnfuY8eFuuJRagx/jUf+6GaiqH2ae5nUtcttBTtNXboJZYsUZdkvh
 mbiUUHGIY4ir/mIa/cqi/BNYqvDCUZ2xgs4SmbpIJ8gxHsAAAMN9AnDO/HHWlxMwPNeE
 sPKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792260995; x=1792865795;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0nRvE4iYzZZkY8FL+vx+dpAmS+CxJcSbG5OBNTwgPiI=;
 b=H1MRkod/+DuAMETcZTZJQ+SEHoD5ws+TYMl8gJDT6FvPD83WrKjCYAMZKyNV2hqZBE
 Z+4c0gAEe5Sgs3S4op4KX9qRLNj5YdpIS6oJu4boVn9dhkazb/APPVm+sQCWTcY5nJbR
 TifwNK92fcDpjT+qkBBPkXzCjV+XHIRINRbNcntA01WP39+cAeD9HKK0MQc2MACC/AUs
 5PTKXVV5ZMkxg/AV/wJBB4/YXRuSrDMPBEfBVtsCcVfUD7k761eTn9zAbor5Y31xtb9U
 F87W6dTHkfr3D6NB2w/Vbzv6qDYeIJiBw2MBT1xdDuNX8SV5sp1nYISbFqaH83zNMsWd
 B46w==
X-Forwarded-Encrypted: i=1;
 AKwUvBxJYZOtXX7Dr01I6lOiZQ0PhKp3UOu09+uVQfDyaMQabXIMvy9JD4nJJMqzpW4uuIBGrge3hvd7BBc=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKpm8fgCEP3zfeHhk2l6IrnmcRHp0JOwA2IBJ2/mDsnEBZy9tjL
 e7ANZ5+6IxNmGs0PJBJoxW/ZJr1xesuA1qwBUWB3kyWqpcqX4d0tmsgPiv2eQpggqmrtKM5E/5z
 ZdwQUtfZ9mqvM0FHJfJ9jehgnU1NlpL7F3GdFLAWblqZswQIXA5p01L19OGSjC+y1goO+GsA=
X-Gm-Gg: AYBFou2/hDjucM5tWFwzxeKdl3Xcp00eXcRahsyQ0/k95I2jPYTEZj7/7QiPkTq9s/p
 r3WifBbOy5fIrliFUwwDJyyGNMv2MtYJd4UZ5F6AO6ZCyOktCBBY0496bPEzecasZWq9RLjUpXi
 TEUkO6bEB89Yb5VUnVD37ocOYCR7IivGYWIQb5W2AD2ZwRiVilIK1AUu6rG3pUAK13b4d45K6o9
 rcGMUqNw0iLVWv5uFEJ+WBBA/T5kPx0lgAlCI3XyzzpN2Ngi8+V4R+AmFYVQAXqoo/xmA0mARPD
 QjKkF02wRGtR3gbOew5IMVP1XLeAEa2Y4Y5HdJ0Vqit85c8rK5bBF7M3xX3LRMYTAD9MM9ZpAui
 4wFBCOfPNMebyfs17ChNWYtQS7TE=
X-Received: by 2002:a05:7300:ec8b:b0:341:4f3:8f84 with SMTP id
 5a478bee46e88-361a14651b3mr4203991eec.13.1792260995144; 
 Sat, 17 Oct 2026 11:16:35 -0700 (PDT)
X-Received: by 2002:a05:7300:ec8b:b0:341:4f3:8f84 with SMTP id
 5a478bee46e88-361a14651b3mr4203954eec.13.1792260994417; 
 Sat, 17 Oct 2026 11:16:34 -0700 (PDT)
Received: from [192.168.1.8] ([122.177.246.33])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3607ee0cc23sm21263364eec.2.2026.10.17.11.16.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 17 Oct 2026 11:16:33 -0700 (PDT)
Message-ID: <54ae7a34-2ec9-4051-ba16-136a0228609c@oss.qualcomm.com>
Date: Sat, 17 Oct 2026 23:46:26 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/msm/dsi: fix AHB clock staying enabled across suspend
To: Joonhoe Kim <26rote@gmail.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar
 <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 mahadevan.p@oss.qualcomm.com, rajeevny@qti.qualcomm.com
References: <20261006-dsi-ahb-clk-suspend-fix-v1-1-67da848e1b0a@oss.qualcomm.com>
 <20261016125036.1069-1-26rote@gmail.com>
Content-Language: en-US
From: Arpit Saini <arpit.saini@oss.qualcomm.com>
In-Reply-To: <20261016125036.1069-1-26rote@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: x_cpbSYgs4DVz1kE-9HsgYWJh3xtLEEn
X-Proofpoint-ORIG-GUID: x_cpbSYgs4DVz1kE-9HsgYWJh3xtLEEn
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE3MDA3MiBTYWx0ZWRfXzWP+zawHOFKv
 lhiejpCuyV/NfYzlccEI39G9W/dh0clbhM5jbOIca++OpiIz2YjvXkM5Exolxb3XH2QVBjJG+me
 ntwswzrKbUlT0elQmYonGmgyI31TYC0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE3MDA3MiBTYWx0ZWRfX1Ypq/eCBDG5p
 xdFGG5WMRtS/30eDTWrSr8/IHyUu5QdCH156pt31OfIlu8vTeGDdjoPgnSIwRf0+rRKqTeCSHs4
 aP7GF352UiVYrUTDwhOc8dfTTBeKxxGZFHwGNP3wS1TIUHI0biT0GPSA3eIC99PNIVCtmkcRdhA
 +MdWaAZFK72aB6lkIZQgkPyL4Mup53zBmUgTravzPjzHA3UQDD+1eESJ+JTsWU6ANJol6ItG4oi
 Jb1CADL8d+10MFBLh3QRz+mnQdJ4p7/Z1x4OfwrYyp1XH10Xryo3HuzMkBZ0u9Ih8RNdRehj0Ay
 fZHuQpAujqSHChcvXenbjnqJIpr8fgLYMVo2jx1IQd0Tvm/xhp7ZtDu/Nj4fK/7CyKJWrneM3v2
 uuE63HWpLfXfXuAJUm+zhZEjrXpPeOZklWEXvQBunFViwX00J+HvUAAI52x7S4BIUGkirExt6+h
 J+6vqTYYsRNlZsHwPyA==
X-Authority-Analysis: v=2.4 cv=SKzXx+vH c=1 sm=1 tr=0 ts=6ad3bb84 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=Gy7JURgNfp+0T9DH7I4t3Q==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=5upmOk6ioxsuaylLKAIA:9 a=QEXdDO2ut3YA:10 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-17_05,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 impostorscore=0 spamscore=0 suspectscore=0
 phishscore=0 priorityscore=1501 bulkscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610170072
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


(Resending with the lists on Cc; I earlier replied only to Kim.)

On 10/16/2026 6:20 PM, Joonhoe Kim wrote:
> (Resending with the lists on Cc; my earlier reply only went to Arpit.)
> 
> On Tue, Oct 06, 2026 at 06:43:53PM +0530, Arpit Saini wrote:
>> pm_clk_suspend()/resume() only call clk_disable()/clk_enable() for the
>> AHB ("iface") clock, never clk_unprepare(), so prepare_count never
>> reaches 0. The clock (and its source) stays reported as enabled
>> through s2idle suspend even though the display stack is fully
>> suspended:
> 
> I looked at this on a Lenovo Legion Tab Y700 Gen 5 (SM8850, bonded DSI,
> v7.3-rc4), comparing the current code, this patch's approach, and
> preparing the clock only in the PHY runtime callbacks.
> 
> In s2idle with the display on I see no difference: in all three cases
> both PHYs are already runtime suspended at system suspend,
> disp_cc_mdss_ahb_clk has enable_count 0, and CX collapse during a 100 s
> s2idle is the same. Is the clock really enabled during suspend on your
> board, or only prepared? Reading clk_summary runtime-resumes the clock
> controllers, so it can show a different state.
> 

Hi Kim,

Thanks for your observation,

The failure is that :

[   55.005539]  disp_cc_mdss_ahb_clk [19200000] (enable=0 prepare=1) ->

enable count is indeed zero, but the prepare is still non-zero.

The enable_count is correctly reduced to zero by pm_clk_suspend().

However, pm_clk_suspend() only calls clk_disable() and does not call clk_unprepare(). 

Therefore, the preparation reference acquired by pm_clk_add() remains held during s2idle.

> The difference here is with the display off and the system awake: with
> the clock prepared from probe (current code and this patch), dispcc
> stays runtime active and MMCX stays on. Preparing it in the runtime
> callbacks lets both go off. I have not measured the power difference.
> 
> That variant survived 30 DPMS off/on cycles with clk_summary read in a
> loop. Did you hit the prepare_lock deadlock, or is it from code
> reading?
> 

The reason for avoiding clk_prepare()/clk_unprepare() in the PHY
runtime callbacks is that the PHY is also a clock provider, so its
runtime resume could potentially be invoked while CCF holds
prepare_lock.

Agreed the CCF prepare_lock deadlock is currently a theoretical
concern. I have not reproduced it.

Thanks,
Arpit
