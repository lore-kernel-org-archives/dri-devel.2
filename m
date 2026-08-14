Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B73EAC5CFCF
	for <dri-devel@archiver.kernel.org>; Fri, 14 Aug 2026 19:53:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E398810E1D8;
	Fri, 14 Aug 2026 19:53:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZFaBlX+M";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Og443+g8";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 33B1310E1D8
 for <dri-devel@lists.freedesktop.org>; Fri, 14 Aug 2026 19:53:40 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67EJgduV3187453
 for <dri-devel@lists.freedesktop.org>; Fri, 14 Aug 2026 19:53:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 H1O3PoybB02/UOh93Lrjs6E8by2ys+G44a086V6qWPI=; b=ZFaBlX+M3J73p00d
 UpULt7QRnAvBEmUbeC/Qt/mqkmFG7iAnNlJC/cHqcc+ngiuSuqmPtA92OFjGjf6P
 WcuSmC5q+oh1itjXPSXvwKinlYz6cXnuYzDTyD8YpKiP0ltfj+K3UDrxBoVnZid8
 IBLNCWEH4d2uxNBWhmZVQY+NhAi0VE+oxGYz38/rBJAVc9ql+7QqvHshPZ+LUDWu
 5v6oxZFugCEnHb5gsbGglazYVG3h8dPr2uD6Dd6aleh+Nb3mRz5hik+5QIDdz/i7
 C22PWMB7Qj/2Ftbtb7Ysj6PnOkMF716va9jiYb/hUBjdQQwGE6qVx6yA6xp+/W7A
 awbRGA==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g28sk06dk-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 14 Aug 2026 19:53:39 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-38f0fe57470so2636502a91.0
 for <dri-devel@lists.freedesktop.org>; Fri, 14 Aug 2026 12:53:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786737219; x=1787342019;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=H1O3PoybB02/UOh93Lrjs6E8by2ys+G44a086V6qWPI=;
 b=Og443+g8p5Zn1zzJTib/wN9kFn0qF3VIlV7E8eWnqXTis5YU25oie2oywKOjc0N15M
 XHsU0xtEBkYipxGumok1rNjFzGrbSoL/XDo7zfAxX+KNtkuqQ8IWiowUyyWqc5xV2ITG
 d6umgF0ZWIqqeAUxoVRZUT0CbRpub8OL6YizFfh8uKOwHZSGwewUs94er/UJF0gjky1V
 anG/U2cXWPQ6LB5M8Rd3/go5sSXi0VmRrWdyDLHPEq4BzQ2LMVkFXb41N4eiUycYqdhB
 Gu299jNKsVp7lnKXJGPj1VBEPMepF/n6KQ1935uqB9NxOS0+lQi5PrUj3F2b3Y8CVJmE
 M00A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786737219; x=1787342019;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=H1O3PoybB02/UOh93Lrjs6E8by2ys+G44a086V6qWPI=;
 b=RrXMnFmBv7+erO+4++7CFGGikBmvNCj4VQufq8W0ODeb5e4mc2oIcPfjJeLaG8zKK8
 vUtjoxySqLTdAUqLesgDIFuJALQIrW/p35E+1MDDTgdi0XHgpKo3v2DtAUMFuw05qX4y
 J1StmkW97C2h6cDFL7pf9B2vcR/3gK2012YtgtPWaLILw2cHcjV5YnqMOC+I6ikA80nu
 9j+fp22ZdKPsUO/jguvsPdGOZg/qXAB2JxvzAYkxYbkak5qY7s5pEetVumdC/KvROZ49
 MlTJ/fu47WuebTgSGAmoiGr7KWRkcZjJGOKBIqDGu6nLRumVhLnnyC8A6ErjJHKmyqVT
 3ylA==
X-Forwarded-Encrypted: i=1;
 AHgh+RpC5LicJMb2KXdmqTu6mGgQM2dxW6A0NfZgxL5k52aoVq/pnQxOaCbtQpeTiFR7iN3c2ry7TWpv8V4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwvqD4qD2Qow3Qd4yAfzps6xlJFTZr0/WFSB2q+uZeA81KchxmC
 aRf4IvVXCcMAcrCRI7c++GYx440AhJnqzCo0bWPlwz7xtKH8U1cFW+k74LrxLhIl2M5spB2/+Qw
 9A1n2HtCvZYPGM+AXyyMH1thn8WSF12fWHa9+bHxirGU6OsqdVlcGC7As8qLM/4d56gTnW7g=
X-Gm-Gg: AR+sD10EztRHM7burg+nCNlTZkB9qIeWLsi4JA/mkQFcoCU1frm4jUHYj6kuaMmFOL4
 6LXK3MDuuWxnqzo0DKCWqMUglieJwRUM2dnCxYDZ5EW2gOfj+JdBDnuNETe7W5zx0+s9RQFy+DT
 3NeKMwRoslE+Tdp19BubDPnwYGZh15b90DD7Z+xiXhSAPk1zf2ps36Kkh0rHBXZHeRDEqXLi9DV
 m9v5FzlrNUejhFa6Xpwn1hlBVV/yjbjnI7HgA7XL2o9iPRca0rt/Ljk0k7bThRd3YhDmQl/FSqA
 k5tdLNnHnKW3pXYfxQ5yETvmpI20nbJLZnoo4vPSd+c1Wu2gtigrsmyFG4oJFEtpRL0kXuj62iO
 xqEguQimtt8Q1lEoAtXgqvvm8HnHXsgtrOhBMTrmet+uoBJmS8JKyoQ==
X-Received: by 2002:a17:90b:3841:b0:38d:eaed:4adb with SMTP id
 98e67ed59e1d1-3931f614141mr12290136a91.20.1786737219034; 
 Fri, 14 Aug 2026 12:53:39 -0700 (PDT)
X-Received: by 2002:a17:90b:3841:b0:38d:eaed:4adb with SMTP id
 98e67ed59e1d1-3931f614141mr12290098a91.20.1786737218563; 
 Fri, 14 Aug 2026 12:53:38 -0700 (PDT)
Received: from [10.226.59.182] (i-global254.qualcomm.com. [199.106.103.254])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1413889bca5sm17250798c88.12.2026.08.14.12.53.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 14 Aug 2026 12:53:38 -0700 (PDT)
Message-ID: <ee1ba786-03e6-43da-bdf4-cc57673f4681@oss.qualcomm.com>
Date: Fri, 14 Aug 2026 13:53:36 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] accel/qaic: reject BO sizes that overflow page count
To: Hao-Qun Huang <alvinhuang0603@gmail.com>,
 Carl Vanderlip <carl.vanderlip@oss.qualcomm.com>,
 Oded Gabbay <ogabbay@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20260708031959.966009-1-alvinhuang0603@gmail.com>
Content-Language: en-US
From: Jeff Hugo <jeff.hugo@oss.qualcomm.com>
In-Reply-To: <20260708031959.966009-1-alvinhuang0603@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=LKxWhpW9 c=1 sm=1 tr=0 ts=6a7f7243 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=XvhK1WYLh5LTG0QYcLAA:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-GUID: rpHBnx3kq4TvF3OXjlJ7bznShT7zXo6r
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE0MDE1MSBTYWx0ZWRfXxFTVIgEO5PLl
 lC4aApbmHIwurcuxZKUDejduhlJFRcaS65vY3XdN2cv/WpNh1nkk2QLYBpMY8LvzTuQxunb7pA9
 iTkp98Y0tXU/M7vBVBcJHX+75jC/fiI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE0MDE1MSBTYWx0ZWRfX1H0nOuh7+kIZ
 yqY8Wu8QxoTvkpvbGA7uvSCyZtOZsS2XSGLJALNKP2mdjnSbA9T0LcF1JbVuoUo6UGHGoZnL+jJ
 2D7IdXjw2P245m68w+WaHLdF3drxrUHAN4uJHceZLEVvwfoYeLwJ6M8xqrDObPOuxx00uaoeh5E
 iRhbmsuCq1Ktn22gPcuuJQUDL/iNW+B2KgnN4mcSrYys1ayVA+axIuB69ob8q3Ot0Ay8sJUEyW5
 XThoHckKnsW4PZuTDBDpIruXGXJYe1So9c09PVVcGtFhto52XLjr8gfIlRIiPxPfK46kDUfPupo
 gsY+NarnuLE4Ev5N7nVQPz5sx/yOfEkZfXClZ2+rRVN4bCMb/mzkFRGbkrsoVL/wkYHylCwFEV6
 n/FUBcsHCFH/FJUmNlN869OIluFokdr01BXKrBu8v5dwiaziPrZ5lTPz/15pRKD2PZ19OO3ZDaV
 An/PQVjE7DkFz652ZVA==
X-Proofpoint-ORIG-GUID: rpHBnx3kq4TvF3OXjlJ7bznShT7zXo6r
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-14_07,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 spamscore=0 adultscore=0 clxscore=1015 bulkscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608140151
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

On 7/7/2026 9:19 PM, Hao-Qun Huang wrote:
> create_sgt() receives the BO size as a u64 but stores the number of
> pages in an int. qaic_create_bo_ioctl() page-aligns the user-supplied
> size without an upper bound, so DIV_ROUND_UP(size, PAGE_SIZE) can exceed
> INT_MAX and truncate when assigned to nr_pages.
> 
> When the page count wraps to a small positive value (for example a BO
> larger than 16 TiB on a 4 KiB page kernel), create_sgt() succeeds after
> allocating only a handful of pages while the GEM object still records
> the full size, so the request never fails with -ENOMEM. The temporary
> pages array and the allocation loop both use the truncated count, so the
> backing SG table ends up smaller than obj->size. Later slice operations
> validate against obj->size and then clone ranges from this short sgt.
> 
> Compute the page count as a u64 and reject sizes that do not fit in
> nr_pages before the narrowing conversion.
> 
> Fixes: ff13be830333 ("accel/qaic: Add datapath")
> Assisted-by: Claude:claude-fable-5
> Signed-off-by: Hao-Qun Huang <alvinhuang0603@gmail.com>

Reviewed-by: Jeff Hugo <jeff.hugo@oss.qualcomm.com>
