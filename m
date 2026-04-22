Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44296FA1FD7
	for <dri-devel@archiver.kernel.org>; Wed, 22 Apr 2026 17:30:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8F1D610EA78;
	Wed, 22 Apr 2026 17:30:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="V1h4iMsP";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="OivQiTLM";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8F67E10EA78
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Apr 2026 17:30:11 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63MG6amg872740
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Apr 2026 17:30:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=
 qcppdkim1; bh=x+kv21v1RlyCw+hD9VXFd9bZ7kOUY5AThNH33zvfHGY=; b=V1
 h4iMsPgq4ohwYar4O+VpywY2FI7J5ZECADkWOVMLPopYZvebSw1IHfw0t3iWFuYY
 isDy5835TfahR5GnFTT6gr6khGBoDe2zNZ+lPunsbTLNvF0/t6FsRQDOOcsy/4D/
 6exM2InrWIiAZ2JdbU5PgaQqwKen0a7Ll+TnTgXcADs1tIvbp5YR7T5Z60rabcfi
 p4j7CK005eklkj9MvCaBfDrJZOq1onJd5b/Sk4z8PQN2dnSRxxMb1EjLO1tvIWIX
 Oc11cbGAxEXLgeLuh4XTdJbnOnohIPLmaGSmtIIjTSyMVVK3oEHZ3/Tp3rfl4vKz
 hqcoGifjKmWPpCyR5+ww==
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com
 [209.85.160.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dq1jh0acc-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Apr 2026 17:30:10 +0000 (GMT)
Received: by mail-oa1-f70.google.com with SMTP id
 586e51a60fabf-41c08879ba3so12830637fac.0
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Apr 2026 10:30:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776879010; cv=none;
 d=google.com; s=arc-20240605;
 b=PRAq2J1YdIN7U+dqb6LHSJtnphxrGnvhIvg5Pj123EyRMHvPIdEmNLTi/BlAWOJWYy
 i1wvNnQHH6Cs9KbwIhm1YZsu7NeW+BPZTQdQrcrHlDi3Drlsfdg1tFCOceJbQ8jxie8Y
 UMh1BjubKVwRn2vetpkuM9XYFNzFfyKgstyHLk3vQKw0msKgJ7tOVdV9rLsAP6nSkzdz
 Z91lizez+fqIszJlDwZih3mSg7MAC6sbZFfgi22QsOsSrxCbKwlHXLaWRI69HsBZM3Vx
 R+TJAIVSnhhYinRMvZNmDc7I+fuwXzHiY+7oTbB1A7Vs9lyqWbJwL9mVh51gFyTrABBR
 KwMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:dkim-signature;
 bh=x+kv21v1RlyCw+hD9VXFd9bZ7kOUY5AThNH33zvfHGY=;
 fh=7E+QxoiNpJ7fFVUqiw/rTQHmEgDZfcKl7idRAE6GqSs=;
 b=lkdtbcyva9l3O5C1H/PrEgSDulpNl0bUQ52yZP8R+J6kO9vbqil3386zTc0HWkXYL/
 6wzrFm/fu9YB/dzo3SuDipV4y7RBcS0BQxVfpB0BR8vBJqsEd4o269dFMe/DP4AhTkZw
 E8M7linVC1M2mkjGV208UGbQCu8VgITLhnD00RLpM65eJF5YdPssYGVfAmAgGgdrSg6n
 R3kPPipI1gYsjewedtLk8xy0VGJ+Ry7VCeiIV1bQ7eYGDWdHNR40dRVJYqVRSxEDO59T
 4GUyIrkSS6czfpzi30VgVppmN0HN9pnRvHvwBQLaL561k5VVYe+gMMINqrM+hz9PFuk0
 9ifg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776879010; x=1777483810;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=x+kv21v1RlyCw+hD9VXFd9bZ7kOUY5AThNH33zvfHGY=;
 b=OivQiTLMB8bH8EBs01rzterwDtJ9f0HX7Z/qO/FnjZdwG/Mr7WTHk1V3F74sTPGhJI
 8gpgBfje4g6z9bYV8s7wDY3EzjNvtkvkp3IHEE18NwMNFavPOC6G5uHvstozciKebb/Q
 tpmsuVtRCCnkn1pheCgraubr6AYW9kqwZ+e0C0w+HocvnxkN8GygASnjs48jA18pDOTr
 HyIZWtwFdn7yvK+bjQ5nceQ65cMnwmV6vtuPCuArlgFT4HjUchLIHKDJSp1/eHCKh40f
 CLfbgokwWg+rzKf14v191a5L4sa808iyDqXcGnmW2r+t3jy2k2FfMgHUUv6qmH7MyJ9I
 SAug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776879010; x=1777483810;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=x+kv21v1RlyCw+hD9VXFd9bZ7kOUY5AThNH33zvfHGY=;
 b=b63yLcyO0uNaFJ6kna2dOF3+G+Thqoh+xUI1b3Nsg12inik5q0PPJGNVSuBrnX4zj+
 f3KQDIaLOQr+Vh/0LnsQTh/5211gAWw+tvBck+dSqFXPW86FQriN5QJibfn9fnIK/qFL
 X/xltgAMoT7o8ZTfoc3eKcU5SIAoieczmW40rxfahvPhl3SthrNSgz8MT1MJHHo9iqMo
 c27X8mPOXuW3IKTwo/WwqW/C2fg2c7mQgRqN7Hb5QMDnttzlBwOikEECl+iaKJFwk/An
 48MKZhW6ogDjIblbrEu9VcPp/ur1Xq2PKZKoq5p9qFtnDn6h80dj9iZWmUI6LmoORd9k
 kIoQ==
X-Gm-Message-State: AOJu0YxDsbwdRxW393SWebK80UEmAtcOYSxjNLOvoqAVE6rHwi62mTff
 0DxInsaH2fES86Qvxdm/qafodFqGNqBbrQ+mUixlIojX80MONWRnpAx+5T72qqYgJuqQhKg8P4L
 Mq23VCmoDaHSKb4Y7/yNY13h/RlSvs8z+mMIW18YPjlXmRH1u0LnaFbsqnocw+70tPQAMQwzj1P
 HqQMZ1Zx3KHEMsMyEsMXYI1baP7D49hGrusjhAtb0ivrRgwg==
X-Gm-Gg: AeBDieuHtYJW0AAM72kyWhxcQMP7hvhGL+QdrdQoCDafV/jbzqWM2pmk5IYlF9zjfYQ
 RkhSmiNAB8bhpbUgL8SlcEWCQf6Wv3Z9tSetlvq7ghw0o0PYJZN8YGDBCINBZcPwiYFdygPvXX4
 9idC71uE/vGhHtFRiDl/d0kB515QXriKHReSs5UaXOWUuyQn71RKSLepHiBUcp5ckVJhgjTX9t7
 osOj+iIiI19CG0mlK3gZ8bWGJSO9SvIc1ZC7/SNWO5FDjYz
X-Received: by 2002:a05:6870:89a8:b0:42e:9bd8:479f with SMTP id
 586e51a60fabf-42e9bd89791mr4009281fac.3.1776879009598; 
 Wed, 22 Apr 2026 10:30:09 -0700 (PDT)
X-Received: by 2002:a05:6870:89a8:b0:42e:9bd8:479f with SMTP id
 586e51a60fabf-42e9bd89791mr4009236fac.3.1776879009015; Wed, 22 Apr 2026
 10:30:09 -0700 (PDT)
MIME-Version: 1.0
References: <20260420222621.417276-1-robin.clark@oss.qualcomm.com>
 <b4hkax45ohmz3dk4b2wgfmq73px7er66wqxixquxhwd64ngboa@zu4frfofekef>
In-Reply-To: <b4hkax45ohmz3dk4b2wgfmq73px7er66wqxixquxhwd64ngboa@zu4frfofekef>
From: Rob Clark <rob.clark@oss.qualcomm.com>
Date: Wed, 22 Apr 2026 10:29:57 -0700
X-Gm-Features: AQROBzBaTNAnhQpwHwM1yr1F-gZQj6ZcnfACIOuyGg5pITZEduYhvobo34Eh-AQ
Message-ID: <CACSVV02a0tt83+G6svZ_foEuoZ=aag75z7D8TveQnLO74pTMww@mail.gmail.com>
Subject: Re: [PATCH 00/13] drm/msm: Add PERFCNTR_CONFIG ioctl
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
 freedreno@lists.freedesktop.org, Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Bill Wendling <morbo@google.com>, David Airlie <airlied@gmail.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Justin Stitt <justinstitt@google.com>,
 Konrad Dybcio <konradybcio@kernel.org>,
 open list <linux-kernel@vger.kernel.org>,
 "open list:CLANG/LLVM BUILD SUPPORT:Keyword:b(?i:clang|llvm)b"
 <llvm@lists.linux.dev>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Maxime Ripard <mripard@kernel.org>, Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Sean Paul <sean@poorly.run>, Simona Vetter <simona@ffwll.ch>,
 Thomas Zimmermann <tzimmermann@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIyMDE2OCBTYWx0ZWRfX/QO2emQgnXD5
 4DPq/wrzIVkhnqofICs3K/McFQrdGDcVX6vJxMJA9dG9P+N2E4z0tcDlZADlysd2Cnnd8vK3M8g
 I+qQcRKJ17Zgy6PGjqt4op7Tx2UqgjNeC+uBm4chFRdJHTtBsCuHzXxRWp4zo+bleRA2zXpOvg2
 BmKM294GU61aPr86WyW8xYWzN8VtYa+bcowW4VWKznbQIAihKHMMGpzxB6dztgeHJWb1zy28Xg9
 KHdEzs4GI1rw8Hy63cCQxUJgXQc794SRVMwQnSLUOoTTdhJ7A+ACidBNOib1vl6/27NgoAmpL1q
 9804J4WNeLNBo5wMX5wpeN59ZyK+3TGxGOY1nCfTfqCiB/kGVlREOPmdEZtLWW29WuWewRTNCHA
 gJnTC5d15R7D4oyp3R4G5ryljwAaFAWAD/++5SBBioJeBFYWoUk7jsnP0ShZCuPqN//k+ilqadv
 L8cLNbrFGBFFlvbuPZw==
X-Authority-Analysis: v=2.4 cv=OeyoyBTY c=1 sm=1 tr=0 ts=69e905a2 cx=c_pps
 a=nSjmGuzVYOmhOUYzIAhsAg==:117 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=rJkE3RaqiGZ5pbrm-msn:22 a=e5mUnYsNAAAA:8 a=EUspDBNiAAAA:8
 a=M9zKgLJNyvpdfU1V1vkA:9 a=QEXdDO2ut3YA:10 a=1zu1i0D7hVQfj8NKfPKu:22
 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-GUID: JYZnls4SfxKUR0HcUgNRh6_DdJ12wrJ8
X-Proofpoint-ORIG-GUID: JYZnls4SfxKUR0HcUgNRh6_DdJ12wrJ8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-22_02,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 adultscore=0 suspectscore=0 phishscore=0
 clxscore=1015 spamscore=0 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604220168
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

On Tue, Apr 21, 2026 at 6:54=E2=80=AFPM Dmitry Baryshkov
<dmitry.baryshkov@oss.qualcomm.com> wrote:
>
> On Mon, Apr 20, 2026 at 03:25:22PM -0700, Rob Clark wrote:
> > Add a new PERFCNTR_CONFIG ioctl, serving two functions:
> >
> > 1. Global counter collection (restricted to perfmon_capable()) using th=
e
> >    MSM_PERFCNTR_STREAM flag.  Global counter sampling is, global, acros=
s
> >    contexts.  Only a single global counter stream is allowed at a time.
> > 2. Reserve counters for local counter collection.  Local counter
> >    collection is local to a cmdstream (GEM_SUBMIT), and as such is
> >    allowed in all processes without additional privileges.
> >
> > The kernel enforces that counters assigned for global counter collectio=
n
> > do not conflict with counters reserved for local counter collection, an=
d
> > visa versa.  Since local counter collection is scoped to a single cmd-
> > stream, multiple UMD processes can overlap in their reserved counters.
> > But cannot conflict with global counter usage.
> >
> > In the case of local counter collection, the UMD is still responsible
> > for programming the corresponding SELect registers, and sampling the
> > counter values, from it's cmdstream.  But by performing the reservation
> > step, the UMD protects itself from the kernel trying to use the same
> > SEL/counter regs for global counter collection.
> >
> > For global counter collection, the kernel programs SEL regs, and sets u=
p
> > a timer for counter sampling.  Userspace reads out the sampled values
> > from the returned perfcntr stream fd.  Releasing the global perfcntr
> > stream is simply a matter of close()ing the fd.
> >
> > Since the counter sampling is done in the kernel, this prepares us for
> > not having to disable IFPC while global counter sampling is active.  Bu=
t
> > wiring this up will come in a later patch.
> >
> > The mesa side of this is at:
> > https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/40522
> >
> > Rob Clark (13):
> >   drm/msm: Remove obsolete perf infrastructure
> >   drm/msm/adreno: Sync registers from mesa
> >   drm/msm/registers: Sync gen_header.py from mesa
> >   drm/msm/registers: Add perfcntr json
> >   drm/msm: Allow CAP_PERFMON for setting SYSPROF
> >   drm/msm: Add a6xx+ perfcntr tables
> >   drm/msm: Add sysprof accessors
> >   drm/msm/a6xx: Add yield & flush helper
> >   drm/msm: Add per-context perfcntr state
> >   drm/msm: Add basic perfcntr infrastructure
> >   drm/msm/a6xx+: Add support to configure perfcntrs
> >   drm/msm/a8xx: Add perfcntr flush sequence
> >   drm/msm: Add PERFCNTR_CONFIG ioctl
> >
> The series doesn't apply to linux-next. Please switch to b4 and use b4
> --edit-deps to specify dependencies.

fwiw 20260411150312.257937-1-robin.clark@oss.qualcomm.com is the thing
missing from linux-next

BR,
-R
