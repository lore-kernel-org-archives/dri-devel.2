Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7814BC624D6
	for <dri-devel@archiver.kernel.org>; Thu,  3 Sep 2026 22:59:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1F68210E343;
	Thu,  3 Sep 2026 22:59:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="STqPdUcL";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JiDJKMS0";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9988710E343
 for <dri-devel@lists.freedesktop.org>; Thu,  3 Sep 2026 22:59:25 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 683Jh3If1412457
 for <dri-devel@lists.freedesktop.org>; Thu, 3 Sep 2026 22:59:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 4U5NGX176yuVJugiJ7gMbzhIMBNpr8RvpY4VyiFmbTE=; b=STqPdUcL/VuSJedq
 gAU3oNowGaTacVfcmzIp7lfywwGfsyCGOByLY1AiAU+r3FtrjNtKLH8MWGFEAPdJ
 t7JpUWNkbCAoxsWSroUCxhu9G5Ib3QT29+jWZyAlhlenjJiKINqPuld9k/euRapH
 W1rxhPBd1aYJGZu5P/P4buiLAtKOoWLKcCD+2es1sKYpOqpEE9iK4UW9eZk70ffK
 XqUK9Blxn8tUgURz421KIKT3LvSE2hs/oE3d9QP8b2aj3POhXXRGL62fPJF/3789
 G3b6J6bJ0alILR4WX9aO5vX4WeDU7UzNSgOTNce+q/XuKNlARBhpmvDKucEKidmp
 MoZPAA==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gf6tx3aa8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 03 Sep 2026 22:59:24 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-398dc3d8f0fso1750868a91.0
 for <dri-devel@lists.freedesktop.org>; Thu, 03 Sep 2026 15:59:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788476363; x=1789081163;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=4U5NGX176yuVJugiJ7gMbzhIMBNpr8RvpY4VyiFmbTE=;
 b=JiDJKMS05wUO49dbRjj1/hcKskrZwC3+c3I84iujNMOCH9dsTW7xRmSW1AJmZOSB7i
 6f+ZCQtmni3fhaNdQ7TDQk6PqeA6g5NFljaMsBoNclp/rXYMny9Dzkbbm6I22HKS//Ny
 v4ywZN+3DDgV8vfV8ea+Wsvx+fOnsusFf/neTa2qOg8mSuriBq8qsDUSHcbPEhFzo21y
 b5frl5kZNFWW0u7r1jxUvjwgaOyHQ7F0VpZi3eICT9OD27G3HvmHbTorP8hdKAqUX/Wt
 Spz2pSs5D7IUrZVn9ZX4UJwlFHyIFYR1Q/U9h4aSKXH0g93FgRQH6hQj7XPKs6CA8mwl
 VE0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788476363; x=1789081163;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=4U5NGX176yuVJugiJ7gMbzhIMBNpr8RvpY4VyiFmbTE=;
 b=JKd4zeuDVzrmhgoCOZGyFhTO+MCRl3E1yeZkfPyTMVJZDAvHj14YuB9L5YiyeDFIPD
 gLYcBCWge1kSg5CWx9K6Yel/8pli2XIHUMK3JQ7B3YhwS/ZucWZIUFjrmR+1859H6vxG
 Z4uQSK3tDyC+BRpzmHwYziBYHfiY/K0pCDfXHhLJabchn1B+ztX7XwtYn/Ibh6JxdogV
 psnBf0iTGbBNW4TBT9Pptw9BeZZ7HqtLmhN8RAulxA69HRWqNvIeYp2P+BqdT4cKyrOq
 xUDc4KbjRTllqMjAuW5BD79Rq8cLtW+eVFJ8cmVo6CxO0dn85DDYKNn28zhbq+94UKOK
 3I6w==
X-Forwarded-Encrypted: i=1;
 AKwUvBymXGhSatze6F5VvzNFSv4gsJsmcEMlsa/pXO9ukRQqaw/Dj7qrPLps5wrPQ6NPfREPfWxxBvNmMXE=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nlwv8h01in3XsyRIQ7sgPYFUY9WYgLs9E9N9jwEb2G4jwcd6b7
 GJO3pjcHGOl6N/rE71JZmdRbXFFhXQ+qwGthFi/4DCZBSejRmnEs0oCzuPX8513QWFEG8LH1P4L
 hzq31dMbZfDErUkYvM0doLwy701/E96YkXmamgA5P69Ypvt2l3hoFdIwN8Lj7MrKOgCTFvAg=
X-Gm-Gg: AYBFou3UFQ1kIayp3y5nMbWNSX8W1REG7jNCF06XK+xniLf4cUfCzm5hKha8fsuc20U
 5yPrDqkcQGLbqTs0B/VVBeNFQ0kNunJCa/TKafAjjHgnqjxkyIapL6R3mMBnk7PISKCvfWC8iWZ
 iiy8AunFRBZl87yPqbcFeOJBIM/pqWUjBPO46BuO3AReUWjY+Ku7Z7AGrfY6ki3/u2stctz/ADU
 P49fKlj2dmH6HK6ySLjLTLPjiP4Gcqcknrw7o9llhdsfyvcZJM8rFXW9+RXzY5ja+1hzQ8O6jRX
 +4nOWbBFUByTl78pnH5wHABT+LLl3LGbCOIVo+AWhon4uEj+M1bfLG2guyHWMRo1HaGChswzO6N
 6KoHgH/I377SN3K7aH/dItgGmGQ==
X-Received: by 2002:a17:90b:4988:b0:398:ceed:b903 with SMTP id
 98e67ed59e1d1-39b080364famr10264912a91.11.1788476363088; 
 Thu, 03 Sep 2026 15:59:23 -0700 (PDT)
X-Received: by 2002:a17:90b:4988:b0:398:ceed:b903 with SMTP id
 98e67ed59e1d1-39b080364famr10264870a91.11.1788476362465; 
 Thu, 03 Sep 2026 15:59:22 -0700 (PDT)
Received: from [192.168.1.12] ([106.222.232.119])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-143240d86c3sm2181400c88.0.2026.09.03.15.59.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Sep 2026 15:59:21 -0700 (PDT)
Message-ID: <30d4a7b4-1f1b-4589-b132-2115cab98b71@oss.qualcomm.com>
Date: Fri, 4 Sep 2026 04:29:16 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: drm/msm: unrecoverable a8xx hang-recovery loop on Glymur ("cx
 gdsc didn't collapse"); killing the offending client does not stop the loop
To: Greg Ociepka <greg@ferrisoft.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 linux-arm-msm@vger.kernel.org, Konrad Dybcio <konradybcio@kernel.org>,
 freedreno@lists.freedesktop.org, dri-devel@lists.freedesktop.org
References: <20260820154428.1278@ferrisoft.com>
Content-Language: en-US
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
In-Reply-To: <20260820154428.1278@ferrisoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: hBkdnLHN4KUeY64XJ-DpgLiiWtFzpyKs
X-Authority-Analysis: v=2.4 cv=TqjWQjXh c=1 sm=1 tr=0 ts=6a99fbcc cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=0ORcs9ZnJQ1kMTrlJhaeYw==:17
 a=zXLAmZJP3ypUEzgl:21 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=LTPlDgW43jYcNkZADGIA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: hBkdnLHN4KUeY64XJ-DpgLiiWtFzpyKs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDIwMSBTYWx0ZWRfXyU4anEkxoUZE
 63DPwiQ7qV7WZaRSk/XME9HtDNuZu+WQoKGgHStgDpXe24ZMMloK8fn4mCoRTCZ8g+/pjI9AbHS
 LBrde97cao4i9lJYBfncAkOhj8km7hXYi+K0GlCHs/0gqGuWdzVSZrnTn1rVB5jnAtP1cYr2uXC
 Iz3NOddm8VMznV0T/tQ4YoSeQYKEvP17g3gxDR04iLsQfCRmnwQKZHItHQ7fPxq8wNyKRvqqQMT
 Lxz1oGHQ/bYKXcavMiBsPXdDIkWnqe5wmORS9d8J8q3ZsWcU8IQRaTNMaUXyZ6D/fkhS99Zz8xf
 HyLB1iL5LNtgP0Fd3q0gNl21kU8BkSfGl9mv3S4H5CrwJKeHmQN/aYMCXO+8xMWu6xdVMFhueBo
 hIpbx3fOomv35obC6YufsPkmIj2kvPiADl206hng+cz8eIOBOSoviCbCVTgcxzA/PbgXKxNguFG
 u4EGzRfFJMQKLBo69Yg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDIwMSBTYWx0ZWRfX1ek16qOuYMfH
 5DXXaG0QqHTDm1WUy8GKid7Lc/CAH/ilOpg92AlwFWiUxy5MUBvZ6iFlHVNZMvQvHYwhepbMr2X
 +QNhPmF1LwMqY2DgKJ2WSNboJztctcQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_06,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 suspectscore=0 lowpriorityscore=0 adultscore=0
 clxscore=1015 malwarescore=0 spamscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609030201
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

On 8/20/2026 7:14 PM, Greg Ociepka wrote:
> Hi,
> 
> On an ASUS Zenbook A16 (UX3607OA, Snapdragon X2 Elite Extreme "Glymur", Adreno GPU, chip id 0x44070041) we are hitting an unrecoverable GPU recovery loop that, once triggered, can only be cleared by a full reboot.
> 
> Environment:
> - kernel: linux-next next-20260730, plus a handful of local patches for this laptop (USB wakeup-source/dma-coherent DTS, CPU thermal trips, an eDP link-training retry tweak and a DP debug-print ratelimit); none of them touch the GPU, GMU, GDSC or GPU clock paths
> - Mesa 26.1.5 (freedreno, a8xx)
> - GMU firmware v5.2.38 (qcom/gen80100_gmu.bin) and gen80100_sqe.fw from linux-firmware
> - niri (smithay-based Wayland compositor), ordinary desktop clients
> 
> Symptom: a regular client (rotating across sessions: chromium, firefox, Xwayland, thunderbird) eventually triggers a GPU fault. From that point recovery loops at roughly 1 Hz; every iteration logs:
> 
>   adreno 3d00000.gpu: [drm:a8xx_irq [msm]] *ERROR* gpu fault ring 2 fence 28f9c status 00880005 gfx_status 00880004
>   adreno 3d00000.gpu: [drm:a8xx_irq [msm]] *ERROR* BR: status 00880004 rb 0002/0078 ib1 0000000000000000/0000 ib2 0000000000000000/0000 ib3 0000000000000000/0000
>   adreno 3d00000.gpu: [drm:a8xx_irq [msm]] *ERROR* BV: status 00880004 rb 0000/0078 ib1 0000000000000000/0000 ib2 0000000000000000/0000 ib3 0000000000000000/0000
>   msm_dpu ae01000.display-controller: [drm:recover_worker [msm]] *ERROR* 44070041: hangcheck recover!
>   msm_dpu ae01000.display-controller: [drm:recover_worker [msm]] *ERROR* 44070041: offending task: <client>
>   adreno 3d00000.gpu: [drm:a8xx_recover [msm]] *ERROR* cx gdsc didn't collapse
> 
> Observations across four separate incidents (2026-08-09 to 2026-08-20; longest 60+ minutes; worst measured rate 161 recover cycles in 5 minutes):
> 
> 1. The reported offending client differs between incidents and can change within a single incident.
> 2. Killing the offending client does not stop the loop. We verified this explicitly: after SIGTERM-ing the reported victim the loop continued at an unchanged rate within seconds, and the next client that submitted work became the new "offending task". The corrupted state evidently survives in hardware/firmware rather than in the client.
> 3. The loop never converges on its own; only a full reboot restores the GPU. While it runs, the victim's surface stays black and the whole desktop degrades, since every recovery stalls the GPU.
> 4. Onset correlates with many clients creating GPU contexts in parallel, e.g. right after a session restore spawns half a dozen applications at once.
> 
> Since every iteration reports "cx gdsc didn't collapse", the recovery path apparently never succeeds in power-cycling the GPU, which would explain why the fault state persists across recovery attempts. Two questions this raises:
> 
> - Is the CX GDSC on Glymur shared with, or kept up by, other consumers (the display path, for instance) so that it cannot collapse while the panel is active - which would make this recovery flow structurally ineffective on this SoC?
> - Or does gen8/GMU require a different stop/reset sequence before the collapse is attempted?
> 
> We are happy to test patches, run instrumented builds, and provide full journals or devcoredumps - the machine reproduces this every couple of days under normal desktop use.

Does your tree have these fixes:
https://lore.kernel.org/lkml/06489359-1b96-43ad-a065-bfb9bee51a10@linaro.org/t/#u

Also, could you try limiting the Fmax to < 1Ghz?

-Akhil.

> 
> Thanks,
> Greg Ociepka

