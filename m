Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 790C6C88E75
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 22:21:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1F59310E1BF;
	Tue, 15 Sep 2026 22:21:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="IV/k2TQj";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UrWNdc0i";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E18DD10E193
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 22:21:32 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68FLZXx1621056
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 22:21:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=
 qcppdkim1; bh=hnJAniUUz5UpK0eAzqlFlmnyP+PG3E6KxIttKsrRd1w=; b=IV
 /k2TQjkUrsTGpshqW8f1AkLpzgE6WqJLnJXyVNHKYz8mozA+vLQbIOpShvI99Nvk
 BGk11nj45xZQZMebNdo7NiYw/EO7W5wcvHVc8eAkRKtGrNMclkKkbe3unomYvdUd
 vFaT1byqggr1zubtRjDzuTG9pECEQdOzFAiv4kdIU3d7CXM0IsQ27dhrP8NvQBkU
 TlOdMgPnM8h4FF25SXM2n03VFD94RLvjnLlaGSHHxie20ptztZeSDX3B4EelrzMT
 n1DLEJiB1mKEp0dVH3Si7JCiMZpC8ZcIigaByfbQDV2F2ANWVcL1rru5kNRyAlZ9
 ag1DWjYpUlLQQuGalXdA==
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com
 [209.85.160.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gq2y2kj74-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 22:21:31 +0000 (GMT)
Received: by mail-oa1-f69.google.com with SMTP id
 586e51a60fabf-46509ab0149so6391319fac.2
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 15:21:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789510891; cv=none;
 d=google.com; s=arc-20260327;
 b=lXRSMRfbikQkdP0JX2C2nis0f/iJSK+LEAVVlg0GvtxjvcRaRO1l22UkzU/cDt3sh9
 E6uXd2N7PY7KETxWsVHKJvlMW2dACChbzK+gcrAkYNcZF4EHOrlIqpjGqGvPfRqsoPnr
 XslN4IjDroi1oh1gufbyYOS6NuqCtWzsbJhrAlUNYSH0ZzarC1RVYGXDjOXZkxSQ9tVI
 xZYKcJdjpB4jboNlQx30mFypumrK8G4MhkLVcrvhsAiMMdKCKU80+iVq9MN9Z9XllCmw
 rwIWp0Y0OlShgHAjD9tONKBSQQ/vwhIhkF1Sg/8OlpEpVq7U/tVNA22+RtKnZstYmItu
 agBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:dkim-signature;
 bh=hnJAniUUz5UpK0eAzqlFlmnyP+PG3E6KxIttKsrRd1w=;
 fh=sZXUy3Pz0XvQFf9CpxtNhGUWOFyrZ9XvzTQ7uMhXgb4=;
 b=ZLYCwbq9U3FnuC3vDrjwwlv+j2EZa3vVoY1FD/2cJ6zrc3WKe3vec1gQuBzGHySaEQ
 Jys6HMnIBLFPsCdUQ/rDWRL1prVkPndf14VE20MSlxTQMeKeQS/nci47peI4IzGFxeW1
 EmVvYexUgbu1HRV/VKxZqbLjG5bCzuK6bnutuK6OYjuqEjlv4ZVYPhW9BD4+1Ez6uwVn
 MmIztjvdvENCb/CebD5vAlULIqCfSQMszM8dPID1BJepuBXS1XvmIDDMRvITEqeSr8AM
 WV/NIT49uRQZj9qXRRo37/2UNnozrOM54osB+QEaiog8gItHxAmJEKPNRf0o4DH1CBhA
 GtnA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789510891; x=1790115691;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=hnJAniUUz5UpK0eAzqlFlmnyP+PG3E6KxIttKsrRd1w=;
 b=UrWNdc0iEFACfskgF8WSnUqftv3+p21EbUI9K9vrvrNnAWj2eFsAu/XfAoCz1jgSX5
 xoGuxfefz60va7Vop4eubLp9CSV/OHCf9XS/0lGO7F1ds3436/3lWarEKJaVIzGVKNnB
 JD+KS/CvKALHpovFhgQ7wpW12AizobGOm2NnsC5dH96SXyRcabqBYSQ16I0F9QflIULX
 8HFP+AJrOld/0r2P7dXKQlE33ofWo3VljumNFKq4QBDtJrjINolRv5k49YAZyJF2+o6R
 O7PH8/2urKX89mBnLswIb+r9CggdFOddwscbbqHtZSZJ/AfuOoTti/QlpY4kPDEszHdx
 i34w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789510891; x=1790115691;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=hnJAniUUz5UpK0eAzqlFlmnyP+PG3E6KxIttKsrRd1w=;
 b=ep5skgBAQp+1s4XaPXfVMxsqAjcWkAYdce9VBUjNMlDhmKZNgwVilZg34brZ6UwtGV
 WRm1NtVFbSbsthmJNC1jr/znlxHMYN8y0lQyZ8v++ftgxgAMcyGfXz8WIzMUSYft7AIB
 an0zQTsCY8WjcjpUjwrjEW3q2MCyQlaVqsLIpsK4CXetGnR+bHvS/VfQDkzJAQEpAaZ4
 az1bELPVV1j3ThaSxUq3ut0wzUYKimkFJeQooG2TgfOM7cF2kdz4mphvoaqSeMVZQXg2
 iyMC7k1pGBnkO7W45xlqA0ZdwFnN8m7L/PPODa/V2aZJ0NqLuFJVhjKqfZ2aiHHWF8go
 wURg==
X-Forwarded-Encrypted: i=1;
 AKwUvByxn6QtmpMDFg7EO2PI8QhNYVmpxMwKjjkNq1uVS/V+UQkORP2AvsR8eEw3ZLoYB6ggP6GwvsSqLpw=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nPwmOjDu49koBNpM4O9dFzXjfTAetr1AnG6Z0TvcWTBrFRrWjF
 +H9Y5b3bXaeXqNbmF3pphQXiNtL8Z7RncCRXMJWttsEHPXgdBmN8+pgYfUW2MtyzHa+MZcZhhIV
 kaNU5y4Vwqn7n+6glqBMWovc0rDu2Loi8C5FXDWPOQPNWE/KsBRmR0OO4lBozI3JC138IGuM6Yn
 JpsS6zroe1+HGVyPY7qWL+VeTu6TRl/LTE8L4dguAI6Os2BA==
X-Gm-Gg: AYBFou2lcTAbc54sZf11n9+S+PnFE7b2Z0wfKTDmOmtmxEbnvfdCs/YsIItvyG+zNB5
 ZXxznW08lauxQXlGPa5TxTqKKBvuYLqFmgd8d/tcYfUp8V0OC3QAcl72iZwYciUyCvAxg7W7rEM
 CaDofvs0xQB2c5OW3V8IDa294gK3v6LWNvxMa0tV76QTg3ORwjT1uiz3tN
X-Received: by 2002:a05:6870:30f:b0:45e:2de4:95f1 with SMTP id
 586e51a60fabf-4847584c51dmr189749fac.2.1789510890839; 
 Tue, 15 Sep 2026 15:21:30 -0700 (PDT)
X-Received: by 2002:a05:6870:30f:b0:45e:2de4:95f1 with SMTP id
 586e51a60fabf-4847584c51dmr189724fac.2.1789510890430; Tue, 15 Sep 2026
 15:21:30 -0700 (PDT)
MIME-Version: 1.0
References: <20260915-work-fd-reserve-unify-folded-v1-0-4d5217d6b246@kernel.org>
 <CAHk-=wjeamU=_RYT9cR3dZJ2N-Teo-N1+aYh7jwhrB=iWXD0cg@mail.gmail.com>
In-Reply-To: <CAHk-=wjeamU=_RYT9cR3dZJ2N-Teo-N1+aYh7jwhrB=iWXD0cg@mail.gmail.com>
From: Rob Clark <rob.clark@oss.qualcomm.com>
Date: Tue, 15 Sep 2026 15:21:18 -0700
X-Gm-Features: AcwNN1UxxSxAxz0XPK7niSod0Tx_HsUs-C3mKdcqDSaFkh659BGkCorPygYZGHE
Message-ID: <CACSVV028AdnTYa6OKDeoJYCau58uTkKMgEdqTn7crNSV8QZxOA@mail.gmail.com>
Subject: Re: [PATCH RFC POC 00/50] file: handle files on syscall exit
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>, Jann Horn <jannh@google.com>,
 Jan Kara <jack@suse.cz>, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 Oleg Nesterov <oleg@redhat.com>, linux-alpha@vger.kernel.org,
 linux-snps-arc@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
 linux-hexagon@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
 linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org,
 linux-parisc@vger.kernel.org, linux-sh@vger.kernel.org,
 sparclinux@vger.kernel.org, linux-um@lists.infradead.org,
 Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org,
 netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-gpio@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, bpf@vger.kernel.org,
 David Airlie <airlied@redhat.com>, virtualization@lists.linux.dev,
 kvm@vger.kernel.org, kexec@lists.infradead.org,
 linux-hyperv@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: SbMfvevh13KLXfkUuqS5CRnP7evE3BE6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE1MDMyNiBTYWx0ZWRfX6fJX3/fJf/JO
 bhiD+eLBtBcwVPR8Gfh6pNe+YqD36aAHb8DCN+iS1qc2IrzEOYHlISTcRyVbQV7I4Zj/f36vF+7
 CfEGf/kSmOTxzILbbojoFSgl2Zj2wp4akS3xyFkwmjvVwDPRRXgYjGpyFGOb6bqdVMUR6cQNV+y
 rKVYtWEEHS2680ZWyLJM7kG+5qv/u6q83N6X3bGg5Ml5KpwaIDbBt52RxQF+eBWbPeapIU9WevH
 PxQ1pSKmlu8d14h0920hvkerIsnYtv1b7Lzt1W2eZT/rjGooF26O5yDi+tONJYH02PjtUqhwO4R
 bxvSCFmG9FGa6teDu/cgwXOIrGKTrKgUeUoeMys7yRU4Ku2Tsjqj9y5L6MvRITEi6fs3xuTSJnx
 dgGC2p8/HH/F5omEJBRFA8uWzJX5anodAZNiKYw1A1RIwDq6Q8YPF9Bjl1xB31IUgrjZkwOw0GK
 pHeuzNvPSJKEl2WiM1w==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE1MDMyNiBTYWx0ZWRfX2slN5VKp4nbY
 R4C5XFKtPXtAartq2nOAVD+ugNf+lBJXgr+OSjmqjiikLjwcMiBBNTKJvBBw24BdessWXBm3nHO
 ub2J7fkbV+XTkO9QE3feY1kdhOd5tik=
X-Proofpoint-GUID: SbMfvevh13KLXfkUuqS5CRnP7evE3BE6
X-Authority-Analysis: v=2.4 cv=IcISymqa c=1 sm=1 tr=0 ts=6aa9c4eb cx=c_pps
 a=zPxD6eHSjdtQ/OcAcrOFGw==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=ZpdpYltYx_vBUK5n70dp:22 a=Z4Rwk6OoAAAA:8 a=VwQbUJbxAAAA:8
 a=2Rxv5svHm-zNKBYa0PsA:9 a=QEXdDO2ut3YA:10 a=y8BKWJGFn5sdPF1Y92-H:22
 a=HkZW87K1Qel5hWWM3VKY:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-15_05,2026-09-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 adultscore=0 bulkscore=0 clxscore=1015 malwarescore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609150326
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
Reply-To: rob.clark@oss.qualcomm.com
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

On Tue, Sep 15, 2026 at 9:02=E2=80=AFAM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Tue, 15 Sept 2026 at 04:31, Christian Brauner <brauner@kernel.org> wro=
te:
> >
> > TL;DR, this lets arch code handle fd install and cleanup. fd_prepare()
> > allocates a descriptor like get_unused_fd_flags() does and records it i=
n
> > a slot on the task. fd_stage() attaches the file to that slot and
> > returns the number.
>
> Honestly, I am *not* a fan. At all.
>
> I think this adds complexity rather than removing it.
>
> The diffstat tells a story:
>
> >  106 files changed, 962 insertions(+), 861 deletions(-)
>
> in how this adds a hundred lines more than it deletes.
>
> But to make things worse, it adds them in bad places: low-level
> architecture assembly code.
>
> Those extra lines are *not* making complicated code simpler. Quite the
> reverse. They are taking fairly straightforward "just deal with errors
> with normal cleanup in the place where it makes sense" and makes the
> *straightforward* case simpler, while making the big picture more
> complicated and subtle, and adding new code to places that are not
> simple and just blindly do somethign that makes no sense in that
> context.

With fd's it is more than just about error rollback.. exposing an fd
to userspace mid-way thru an ioctl is an easy security bug to write..

OTOH, "just use FD_PREPARE() / fd_publish()"..

BR,
-R
