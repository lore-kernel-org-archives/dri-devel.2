Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 870A3C5DF82
	for <dri-devel@archiver.kernel.org>; Thu, 20 Aug 2026 17:59:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EAEF210E12B;
	Thu, 20 Aug 2026 17:59:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="HQ8/tyTp";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Bo1n3KG6";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6DDC010E12B
 for <dri-devel@lists.freedesktop.org>; Thu, 20 Aug 2026 17:59:47 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67KHXvCU968426
 for <dri-devel@lists.freedesktop.org>; Thu, 20 Aug 2026 17:59:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 QFdxtm41wVDEsAP+K+yhfE0hkJ/8UD9Q8TAdZcZFzEU=; b=HQ8/tyTp1N8lZXAI
 n56VZ/6sTM5fPrLrBAnAkhRJCpXBa+kO1jkpNIQ/Qwx6XN5H1yhfEspZq5hN0hun
 AHJf2x61xcubSNZ4LqSXU4ZPlXMyggQyJFOw7oLLB+FzJaKl2h4lHO37PXZ9JJ5s
 oY5wWTmsVXeQ5c4t3Iv5Dn+ufy3+mD6yIWlnaTxFvz08IUMEA4H5a+2NRNxgIvp/
 LlujvrKGgikT6i8hpiwoL5t3i6UvxS1s4aSijuxc+sp+Q4ZrqMwIJGXb2apVHfL4
 55D0uO6RZp6POwxLKSOGxpZkd1TOwB9b4yiiM5g0hCE/4WHV8ZlWFhLMFY1l/Rae
 0snVsQ==
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com
 [209.85.217.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g5vn8aws7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 20 Aug 2026 17:59:46 +0000 (GMT)
Received: by mail-vs1-f72.google.com with SMTP id
 ada2fe7eead31-73883529f72so121827137.3
 for <dri-devel@lists.freedesktop.org>; Thu, 20 Aug 2026 10:59:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787248786; cv=none;
 d=google.com; s=arc-20260327;
 b=NxOpGkReNMJEWvs6VYdBwXoZTSKP+N3UcByJx52qQc+ElraQZIYTq1wR799utKEWR1
 TMFcRkKco7KdIRa5wEZluzaGqxf5O7OLpgLwT8PLV6MgLtVzrxqxzK5iUnaUAVbTm/C8
 xE6iuUMmgP2tuobV3nxOy8NYJ1SIvrWxsYcn5kb5w8QvYMnAHPX2h6ijvHKzWu7O7qtc
 ynSBO1RROu971r/mwtJpPrtFfZQ17fXtVOUysVeMjk2+AGz2Bv2kY2m0sYlkYee7aCX0
 vz2qHSEry4BYXulZ7Lw+i5rCpG/delxSwiNQ2rHfau7fB+XZWFe8bstvELgLK/aQlyRh
 HZ2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=QFdxtm41wVDEsAP+K+yhfE0hkJ/8UD9Q8TAdZcZFzEU=;
 fh=06hhe6I/422EYX0En1xiJHj7gxG5hhp7eKz8Cc/vINw=;
 b=cmtS5qoZj0Yi4nTz4/qM/TrrDIY5IOSbFTBgM0E6peZ6OhTp3zyY+A+DtibjMluLYp
 LSjAfF7+H25376uAbuJ2ory9WCN/ZJpHIka3EGJ9GgqcS0fwQAeQkcJxMTc2eHA5ADp3
 mbPmPr/DKPEYdAsmqVxICS07gylB2Gxavm7cNtAjWwHqMFpJ81KJ8oWhwtds9unTSQMr
 db8QT2UjgAAhOTEgW8bTPyKC8A1ShKVUXBZPrAPHca/rZqLfMOEWOspDobbFmGEpSaUp
 hR6dJrgSUfQWw7tjREmNR/ERKGxh8WeQNz6KKKjzXSFxRytTcI84Sv+EucvL3fQBhiGl
 k2Bg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787248786; x=1787853586;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=QFdxtm41wVDEsAP+K+yhfE0hkJ/8UD9Q8TAdZcZFzEU=;
 b=Bo1n3KG6oT3jqn2xbied4tM6R1ZKEjjxg0hUsLIaIfH3FA+2ByNeIMZGMjLhqvoT5z
 F3bTzUNIas7eHXZdZQPaNHmEaYBxzP9T3kif6JU1CnGSp069fZ0Y5KF0ZwNbPkjNlsdP
 mXFLYUvdbdvjh4XdDrQAJjUIdA8Cd0jghN/MNSkAkZcmjoi7BvZ3lHubITgmZqvodNlS
 j9ZESqYDv++GCCfOU3Fq5owexXiGi2vWv+pELWAAlJwCsHfmEnaXS3uw2wkNPgP9G22+
 BY8BCz9gPvzwkzL/MsTzcdDcxs1X0Nc0jIKWrNqTKgrFivJ1DUjN7WKtxbmZghQSA2lV
 KG0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787248786; x=1787853586;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=QFdxtm41wVDEsAP+K+yhfE0hkJ/8UD9Q8TAdZcZFzEU=;
 b=FaEHDde8uiFGoufMSzoffqwBlLWC+TpPX/4TN2SiHUD1ynfPjwOoORXQBgLH49JfMr
 +52sYYQ47TTcjfQ2rMI6KyPBRQUxP7s2IaloS9ZNDEyn3BTz8z7AMA/EswUdyaKLEt2O
 hLPOHwrc/6gEabGctHXDvFzzJDPdw6T2aSRqakldbE4TcQlrNlvoH2+grMYWAdMTcgPf
 Ny/D1NgYXE2PUPaArJL64Z7wocG0kxIHuPEyQh8ChA+1nJHwMhTQYJt5k0RSTrRFpdFM
 5VI/m7ASBPcIvW8tg2Trapz4zQcxJRoNyayRI3DyTJFfddt4F42bJp9X/EIIAkChwxP5
 lU6Q==
X-Gm-Message-State: AOJu0YzXBXdDNnNFXTVMa/SPclPwbVp95uogJqwdxh4pWmuhO+6Fz6XO
 WiOhiLDxECmjz1wUwPRwW1AsY1zrrsJsP92v/UbCeg55995D7Ijl3kB9ARfbUsSa0SVn/c50D6G
 JRyof6vn7I48WiyhWOZLwx4VD8Fq3a35UY6rGp6goiXtgByEG2VUNGHO1KD6L9tma6kTQ1t7P10
 qOt4nfl9p+cPO6K8iF+lrfnMuX9vWIe/WC2buFQNI+NR09Kw==
X-Gm-Gg: AR+sD11wNZFBcCLJsD/M8E3+IYZlGL2+8BDZRdVHYCVPFt40wjUBsARA/a077hHAy4G
 1oat/RUp6rmENMSUDduOI2VztGYjVF+/tZWf3zpypGl9yu24zfclzlk58N+/NwzzIVlQcnKCf56
 vnVmnFetMorw/otfP2QQ+KS5YaAreyiUdpYiNFVqODWtrUwxAVbvJJjDbQCw==
X-Received: by 2002:a05:6102:3f86:b0:729:affa:70fd with SMTP id
 ada2fe7eead31-77a63448e0amr337877137.8.1787248785607; 
 Thu, 20 Aug 2026 10:59:45 -0700 (PDT)
X-Received: by 2002:a05:6102:3f86:b0:729:affa:70fd with SMTP id
 ada2fe7eead31-77a63448e0amr337818137.8.1787248784750; Thu, 20 Aug 2026
 10:59:44 -0700 (PDT)
MIME-Version: 1.0
References: <20260806051915.2234481-1-pravinku@quicinc.com>
In-Reply-To: <20260806051915.2234481-1-pravinku@quicinc.com>
From: Pravin Kumar Ravi <pravin.ravi@oss.qualcomm.com>
Date: Thu, 20 Aug 2026 10:59:34 -0700
X-Gm-Features: AcwNN1WF_dUI9wIt0GRHRzqxRaap9sD1gWktU2w2B0QM4QA3qSEnyqDEX6FnY4A
Message-ID: <CAPd7Qn3QYyrzBFFjB4+M9Je7uykYgxHiM+vh-mNVJ16QaoPkJA@mail.gmail.com>
Subject: Re: [RFC] Synx: A global synchronization framework
To: christian.koenig@amd.com
Cc: dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
 linux-accel@vger.kernel.org, sumit.semwal@linaro.org,
 andersson@kernel.org, mathieu.poirier@linaro.org,
 konrad.dybcio@oss.qualcomm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIwMDEzNSBTYWx0ZWRfX6K8cwLyEpect
 MV/gPArxCdz2q9/07daCArQFf8IbEhI2IWZDaA8DiPIdMG0fCuplGyb4lKCTFfe7wjJcEYMBVc0
 AYdcSEsaC/cmc5AqwOvHQYk8gAAiu71vr2MY4pXrR3pbayUnvHvXSguYoEZt5qjgWLTCkJgqSod
 sps7DpaObNNgXBqfXpFYeEdixWD/A6366sytwe3Al4yMPh2Xt+uxy/lykSgxFkTF+9T3nlRt5v8
 iBon9xSvS9FLWZ8trmrstP0N+FE1sThhx+FIKQYNPWPL0WjyBlAQHS82vOyIEdRg73h7ODJgWeW
 aipikkD3d46uI7RIHqqrt5CtKdOGd+SQ3Cfb8SwUobxoyBWKdFdPHzvXoWAIhBXRlgMgx9mMMqQ
 FaQLJ4iMTSO2rIPwKHi7vkDEfSnPG99YrHYOZ1qFGcD7yWVD9yXtBijn9YuEkXoHbw2pT0CQygE
 pFd1PplYWrGGMGit55Q==
X-Authority-Analysis: v=2.4 cv=KpJ9H2WN c=1 sm=1 tr=0 ts=6a874092 cx=c_pps
 a=DUEm7b3gzWu7BqY5nP7+9g==:117 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=eoimf2acIAo5FJnRuUoq:22 a=zd2uoN0lAAAA:8 a=UqCG9HQmAAAA:8
 a=7OwBbYa5yZr9SEWkKL0A:9 a=QEXdDO2ut3YA:10 a=-aSRE8QhW-JAV6biHavz:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIwMDEzNSBTYWx0ZWRfX0LLyg91Lz5cE
 NyO9ZozVM3se8KwOVOqqjZFsSJWMRo/016lAipVVx0A2Z14inVSL5nauMGCWMOWRt4U2Ev+Vgz6
 achXzjN0hZbFqgq0xdREiaNWtzkry14=
X-Proofpoint-ORIG-GUID: z_rUKa_6o_fqK6_oC26rJdB-qTUxp8hp
X-Proofpoint-GUID: z_rUKa_6o_fqK6_oC26rJdB-qTUxp8hp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-20_01,2026-08-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 impostorscore=0 bulkscore=0 suspectscore=0 clxscore=1011
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608200135
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

Hi Christian, thank you for the pointers.

[Note: your reply (Message-ID <5f90bb35-994e-48bd-bf49-3001dcefa2ee@amd.com=
>)
is on an earlier duplicate posting of this RFC
(<BY5PR02MB6866E35A2B4241CF3A728A99D3D22@BY5PR02MB6866.namprd02.prod.outloo=
k.com>)
that went out with mangled formatting. Continuing the discussion here on
this thread instead, quoting your message below.]

On 8/6/26 13:52, Christian K=C3=B6nig wrote:
> Oh, well history repeats itself.
>
> Well to make a longer story short what you describe here was the
> original dma_fence proposal from >10 years ago. We fortunately
> rejected it already back then.
> First of all some of the stuff you suggest here go strictly against
> documented dma_fence restrictions, especially no point to point
> remote signaling! dma_fences have a huge interaction with Linux core
> memory management which makes stuff like that impossible.

Sure we'll need to be careful to not repeat seqno_fence.

Synx can be used standalone without the optional dma-fence interop.
It could have the properties of memory fences and need not satisfy the
dma-fence contracts. Here remote-to-remote signalling doesn't wake-up
the CPU.

But we have use cases with synchronization points in the synx and dma-fence
ecosystem for which we could provide synx<->dma-fence interop support
"conditionally" while meeting the dma-fence contracts. What we would
like to keep on the table is a narrower class

(1) condition to assure point-to-point signal completion : remoteproc's pat=
h
to signal must not depend on Linux memory management i.e. every buffer the
remote touches in order to reach the signal is committed before the fence i=
s
published, with no on-demand faulting and no allocation from a Linux manage=
d
pool. Wherever this does not hold, the handle must not carry a dma_fence.
This condition is what makes the amdgpu user-queue fence driver
(97ff19462539) legal: the memory firmware writes into a pinned kernel
BO allocated once at init.

(2) the condition wants to be enforced in code so that reviewer and
lockdep can check. We would make it a per-remoteproc capability and
refuse to attach a dma_fence to a handle from a remote that does not
declare it. This is how Xe refuses out-fences backed by dma-fence
for a long-running VM. Composition would follow the same rule: a merged
handle is dma_fence-capable only if every constituent is.

(3) on top of the point-to-point signal, the remoteproc's Linux driver
has the obligation to complete the dma-fence within a reasonable time.
Interop fences can't avoid CPU wake-up but standalone synx handles can.
Interop fences benefit from the low latency in point-to-point signalling.

(4) to handle remote hangs that aren't related to memory, we need a
watchdog armed at the dma-fence initialization which upon bite prevents
further submission and triggers remoteproc recovery.

Please let me know the issues in the model above.

And to extend beyond the above conditions, the following proposal
from you (which hit a deadend) seems very relevant.
"Tackling the indefinite/user DMA fence problem"
(20220502163722.3957-1-christian.koenig@amd.com)
Were/Are there any efforts to resolve the challenges that are open in
this thread?

> What you can do is to do this in userspace with DMA-buf and user
> space fences, signaling points etc... Take a look at how user space
> waits in XE work, how eventfd works and ROCm events work for an
> overview and maybe some starting ideas.
>
> We could certainly build a framework around that, especially
> eventfd sounds like a common ground to most drivers already, but
> please stay away from dma_fences when you want to do something like
> that.

These pointers are helpful and we can start looking into these.
We could keep the dma-fence interop discussion open and move ahead in the
standalone and memory fence direction. Will share the high-level design.
Please let me know if you need to focus on anything in particular.

Thanks again,
Pravin Kumar Ravi
