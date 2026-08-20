Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1E11C5DF81
	for <dri-devel@archiver.kernel.org>; Thu, 20 Aug 2026 14:48:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0535810F076;
	Thu, 20 Aug 2026 14:48:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="kIlzaYIa";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fM8aWgYu";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8900B10F076
 for <dri-devel@lists.freedesktop.org>; Thu, 20 Aug 2026 14:47:58 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67KE7tZj3235102
 for <dri-devel@lists.freedesktop.org>; Thu, 20 Aug 2026 14:47:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=
 qcppdkim1; bh=yLR4KHznvXfb+H7PWHV2AIGDk1Msa3uBxnhAbjxWO9s=; b=kI
 lzaYIaMnkLJeut0wYrwIzKu5PkJIhncQceAOkWy0QZ+en9V0SahIzZBQ/Wppo6XS
 e2OQQ5dsjGw+/0JN2opJpNdUhvJFbKpEBa4Yuah5jDSD2nB3EMLkmNDZBsY/qOOV
 /uQz6ezGkCfPLaPqCmNE8Yw/T7lIY2GCG7Dur4QGFPGdOqUX4q3ePnNlzPAfd8hg
 w18DDIJ6pn6sBlpf83trCcQyPoUfNxwHqlpgKCOy7oJuJIctvvy46DW3hPkN0x0/
 nqY3CHwpMb6sMB/05dCd8VbDUJuSfzxziFYVVHToUNMt0iCL5l7I0UGfJQ1BitfN
 4YkTEh42f9Ydcsk2BzJQ==
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com
 [209.85.160.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g5xbv9ef4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 20 Aug 2026 14:47:57 +0000 (GMT)
Received: by mail-oa1-f72.google.com with SMTP id
 586e51a60fabf-458326d2d9aso2677109fac.2
 for <dri-devel@lists.freedesktop.org>; Thu, 20 Aug 2026 07:47:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787237277; cv=none;
 d=google.com; s=arc-20260327;
 b=Fud2VhgNdK9V+iHkxNSsdKBXWr733tXZq9aXpZD9trS9OJ7o4/L6zsid9zruOVPIqN
 nMx/8ygcwwXTjltEWIVMC+eUNrvuH312bXST195bt4QlZXYJAjWD7GPjbOJ3v1yUPW/+
 RT0Qlt+C1e68amUOPiBVJ8zVp2KC0Pxhweb9bCsZ/80hVDcIIOyqLRmDc17m3zSagVsm
 00gtxw47o8WwcWK4K7gwk+FZA0TI1Vda5mJ3h47LqTk6JT0IdtAi7nYcVYwvjVj3aObD
 ZyI3IFP/8ZI+0oEOhkV6/o7EQM/4o2gVqjalcy5+zLcit62aYsBB0iIATUhjXFUkdyuE
 jhRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:dkim-signature;
 bh=yLR4KHznvXfb+H7PWHV2AIGDk1Msa3uBxnhAbjxWO9s=;
 fh=4eAdX8C4wDOaiykWMGx/b+tPKuz8kFv1tPaJKiHkqOU=;
 b=A+qcx6Wn9bJnkY2rku8ZvpTFUjXPS8wzWDDxShjwMz1C4hOBteMplsKIeFhq1CXGAX
 X8/Q1yRE+nnjjW3R+TSAxnnQfJGqZ+y/nksZtU+b8IXpHr8d+9ch3wNMk370oEdHhwd/
 urpITeZIgGtV9oLUFYtZ6Oz1x2jvlXaekvfxskV8XjWL3aTQhsd54wzFJZ23wJkF2rvN
 QuemqTpFWn0zyFiat76CCxcFbeVfhWaJRlm9s98IXc05trGOt1/y4kQ5amKx1Y/9RNmE
 9eyM42LxtfWO29tEyVZelRIk/aqAMGaMa1sRo9W9dpAbYV9h7dVzg9gdHB1duasEd6n/
 F9Rg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787237277; x=1787842077;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=yLR4KHznvXfb+H7PWHV2AIGDk1Msa3uBxnhAbjxWO9s=;
 b=fM8aWgYu9wNMNCMsjitbTmz07mL2HBupH8zdo503hvtec2n1mJ23vbaACWwquLAW6J
 3nNbquBqQsi64Xque862Ry2fyQzuOw/CuvCVNygR4BtB7cOf8bIvZJtb5DU8Q03pNWK7
 IsfAN4QLqUB/z4pIYwT47yY+BC2X2DwsbE7udmU3PBLA3AKPmsivEhN9+IhUGjzODcTy
 OsbCeRiMReQOwm7PnDiEWqcgNFF7wjkiYpGgDvDa6PS/HhrMLQiiFl9U8T8fsB3RTeGe
 VoWGGpmbDHFAqpPBTm5y/YdBbjDBkefSHHadxmpKqgN8Xx4XcUGXzcNZseZ/A8HNnY/r
 Roqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787237277; x=1787842077;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=yLR4KHznvXfb+H7PWHV2AIGDk1Msa3uBxnhAbjxWO9s=;
 b=gKNlauJdQ5cLal0IwkNscWcUpSMHoCVy1faRrgc/xXfNd6Fzdy050HV9VFthsaXfW+
 N3/d564acBD5ppxAq1vLu2Db75jc3NDyEWuwzzf0zltZVRDpbc747ATffuGZhEKEykT5
 ffcMQ0BOTq6IqOPDFM3mBu/2+Q4es3BTJPVA59XojNllgGurj9yjyKXh8V7qxNzXqwry
 2+kwFco6BoLP1pvPAcGbqaJ/M7pAxab4T5ihKVvbvBBlMwm4i5+roTjNhMQKzu5Cighu
 BRGmLDG/BIEm/V49PZhKYbmVY14bt/kiJyE3ATZVklA/wUjDinoA5q9hNvrghkjeBiLx
 eiYw==
X-Forwarded-Encrypted: i=1;
 AHgh+RrcxPxwz+rHSaJdXxQMVcapa46SyTTIKcenajlYmCVwWJL1MjYFcZpu4JVc8/Q23otQIoijyOx69nk=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx4dY3BxBJHz7dPLUDgZ5s2o7iAMYkwssqWCjwSJzinDis4OzK5
 UqhIiAY+c4PP5UGl/96fPQi9HzTt/s0D0DgjktS7h8bgktZVJwFNMKqzUHqFxv0eW+C9BIIn9jW
 ONhHy+8e9WReyJDhBxSmCsMHTEMVb4w4a9fimvZgd2P3owcurSxeorJuZSruFWjmDb0mhDbeW3p
 AMFUb9JVXkdtpNUwH4yFo2R7zspAPPGpAHQujCQQRsb49rXQ==
X-Gm-Gg: AR+sD12ZMJHstqGxKfNUBwVicoWzAUmwqSm/fQWHjZeXS9NFrokfJSWd15unu6ragiN
 kWpmq6Llvk2NSIYmesw9CEi9PK5oEn/Mnih9aMwIdUyWyJCxOEvQd99YrE7r9MircslSUIiVKEF
 iyNmQhe1P6VKf9R1ZE9h05t02kpSXQFzAtG3BAtP3GSXtefl7CS/SZbA5n
X-Received: by 2002:a05:6870:718e:b0:457:ed1a:9da3 with SMTP id
 586e51a60fabf-462f68b3ee7mr12218559fac.17.1787237276735; 
 Thu, 20 Aug 2026 07:47:56 -0700 (PDT)
X-Received: by 2002:a05:6870:718e:b0:457:ed1a:9da3 with SMTP id
 586e51a60fabf-462f68b3ee7mr12218513fac.17.1787237276312; Thu, 20 Aug 2026
 07:47:56 -0700 (PDT)
MIME-Version: 1.0
References: <20260817-qda-v2-v2-0-69a02e9090d4@oss.qualcomm.com>
 <3322b42b-3755-45ec-ad55-345125f0d488@kernel.org>
 <10349e29-b583-403f-a89a-9a00c73666bc@oss.qualcomm.com>
 <87dca76c-851e-4cc3-ab91-68949d283b79@kernel.org>
 <CACSVV01eYr6FyA6XBG0xw0yv2dydvTEhcY-WUy07mxM8WwkZcg@mail.gmail.com>
 <318f14c2-0e87-4e07-8173-1511dca67d78@kernel.org>
 <CACSVV01T=ytVJKM7NRoBTAJm7vH+JPJNT9Tftu5X9YskGXerwg@mail.gmail.com>
 <e7b4eceb-cb3a-49ea-bed9-728c958594b0@kernel.org>
 <CACSVV03ypjBYkhRpt=TyDwOKhejKKke3x=Fi_TvxXN-5U_rCsw@mail.gmail.com>
 <fb834ae5-7113-4a86-bb84-ca5115c8d7ff@kernel.org>
 <CACSVV018jB4WRRJ_CUHQmkHXZcqauWJXWGgrzY_HA6cFQ+Q3Xw@mail.gmail.com>
 <dd3da35b-1db6-43a4-ae1f-35620692f51f@kernel.org>
In-Reply-To: <dd3da35b-1db6-43a4-ae1f-35620692f51f@kernel.org>
From: Rob Clark <rob.clark@oss.qualcomm.com>
Date: Thu, 20 Aug 2026 07:47:45 -0700
X-Gm-Features: AcwNN1UDFgTj8DhU60we-UxrgwU5qCqC53mRJdhnjcqckwpTsRRAswI7otuboc0
Message-ID: <CACSVV01o_XYuSzaYGbo9pY=459qiA_fgL_KRHVJH+LH4RYcMzQ@mail.gmail.com>
Subject: Re: [PATCH v2 00/15] accel/qda: Qualcomm DSP Accelerator driver
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>,
 Oded Gabbay <ogabbay@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>,
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Bharath Kumar <quic_bkumar@quicinc.com>,
 Chenna Kesava Raju <quic_chennak@quicinc.com>,
 srinivas.kandagatla@oss.qualcomm.com,
 dmitry.baryshkov@oss.qualcomm.com, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, llvm@lists.linux.dev,
 iommu@lists.linux.dev, linux-media@vger.kernel.org,
 linaro-mm-sig@lists.linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=AMKAkK6n c=1 sm=1 tr=0 ts=6a87139d cx=c_pps
 a=Z3eh007fzM5o9awBa1HkYQ==:117 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yx91gb_oNiZeI1HMLzn7:22 a=VwQbUJbxAAAA:8 a=_Q5Bhtsilc8r9Aqu0AoA:9
 a=QEXdDO2ut3YA:10 a=eBU8X_Hb5SQ8N-bgNfv4:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIwMDExMSBTYWx0ZWRfXyy0kB5fIAipt
 mOtW2Plcy8oZE1d3j8tJYldWl71OCCX1pHgEvmVyQakOOuQ4wtOXxRJwrHb1NuC9Qcyn9UzVia/
 3MKJ1to3V0QcvIHyhrNVhLOZYfdR8taYECm4gPaA+srxJXbbd8I2HtAIhAMbROuQ4Fw4ZQ81Vn8
 iZhraLLyzZUzBL2FE/ngFGT1MiQU06ofTkrmaR7SiiOmUSXe++S1PIZZtMde81l7OLvosSFczQz
 FW5c4PVdAWkT+RICqGc6rpq5dVecVWhgmoIQbTzlU9CuangCpNZMt8zGmln+HXWRDEyIShW5NbQ
 ST5W76/cjZU8PYj5vhGJHLmWSGzxG7EC5LIAjdcNbhmYovSz8mdD41N8wsV0vri5nQ935u5arni
 tShZwiQsWRtRpyCn3wav9twZ+TpOxpHbhHPELbRD7mO+j/+NlZ9kIG3ZMsXYTnA5A1Cfx5q1f4b
 GIcA+UG8MhTSmjh6DRg==
X-Proofpoint-GUID: OyqXS3eq5gpEYwwrA3LJPI9Bu9_-d_I3
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIwMDExMSBTYWx0ZWRfX1dyJBvITLKuS
 ru4cEWoqdhhvKM5oPK1Js0NFaFoZrRHZurX2f4wq9rWZkgUhcqXcOK9GLSyrm78dWyCt4ebijV7
 bjlRI6KEF9a8MhPag8p2k44T6Qima4c=
X-Proofpoint-ORIG-GUID: OyqXS3eq5gpEYwwrA3LJPI9Bu9_-d_I3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_06,2026-08-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0
 adultscore=0 suspectscore=0 malwarescore=0 impostorscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608200111
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

On Wed, Aug 19, 2026 at 11:15=E2=80=AFPM Krzysztof Kozlowski <krzk@kernel.o=
rg> wrote:
>
> On 19/08/2026 17:48, Rob Clark wrote:
> > On Wed, Aug 19, 2026 at 8:27=E2=80=AFAM Krzysztof Kozlowski <krzk@kerne=
l.org> wrote:
> >> The rule of usptream development is that we do not accept duplicated
> >> code, just because a vendor wants to write something new. This is
> >> basically the concept applied all over the drivers tree, where we push=
ed
> >> back against all sorts of duplications all over the vendors.
> >>
> >> What I miss in this thread is why would there be any exception here. W=
e
> >> do not grant exceptions from standard practices on "I want" reasons.
> >
> > I agree that we should not have duplicated drivers just for vendor
> > lolz.  But when it comes to adopting common frameworks and integrating
> > better into the ecosystem, this doesn't seem like something we should
> > actively discourage.  I don't think this is a case of vendor lolz, but
>
> No one discourages it. Following standard Linux kernel practices and
> requirements is not discouraging, do not twist the narrative here.
> Again, it is standard upstream review telling that we do not duplicate
> drivers. Ever, unless there is serious exception needed.

I wasn't trying to twist the narrative, just trying to come up with a
path forward that isn't "no" or "improve existing driver", since
neither of those gets us towards a future using common frameworks.

> I asked why there should be an exception granted? Is the reason for
> exception following:
> "We want to adopt common framework"
> ?

Possibly?  But I don't think we want two drivers to be any sort of
long term solution.  (Ie. as long as venus/iris have co-exist.)

>
> > rather reacting to drm/accel emerging as the standard framework for
> > this sort of driver.
> >
> > So how do we get from here to there?
>
> What is wrong with my proposal?

Maybe I missed something, my understanding was your proposal was
"Grow/replace/improve existing driver instead of coming with a
duplicate"..  grow or improve doesn't move us toward common
frameworks.  Maybe "replace" is a valid option.  If there is something
I missed, then I apologize.

Options I can think of are:

1. Hardware cutoff.. new hw gets new driver, existing hw gets existing
   driver
2. Backwards compat chardev registered by new driver, providing existing
   UABI.  I'm not 100% sure about the feasibility/drawbacks of this..
   AFAIU the fastrpc folks where planning a backwards compat layer in
   userspace, so maybe it is possible.
3. exception?

I'd like to know what the feasibility of #2 is, since at a high level
that sounds like the best option.  Possibly limit exposure of legacy
UABI to existing hw so we don't get into a place of needing to extend
the legacy UABI for new hw?

But #1 sounds like a non-controversial place to start regardless.
Possibly with #2 coming as followup and necessary step before eventual
migration to new driver for existing hw?

Even if we start with #2, how do we handle first-merge-window
bugs/regressions without reverting addition of new driver and removal
of old?  It seems like we'd need a window of a couple release cycles
where both drivers exist?

Maybe others have other/better options in mind?

BR,
-R
