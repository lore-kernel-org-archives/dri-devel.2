Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DE3FC79FA1
	for <dri-devel@archiver.kernel.org>; Tue,  8 Sep 2026 10:27:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5346410EB1C;
	Tue,  8 Sep 2026 10:27:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HJrNuELy";
	dkim-atps=neutral
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com
 [209.85.222.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 53CE110E8D6
 for <dri-devel@lists.freedesktop.org>; Tue,  8 Sep 2026 10:27:17 +0000 (UTC)
Received: by mail-qk1-f170.google.com with SMTP id
 af79cd13be357-930f618435cso493571585a.3
 for <dri-devel@lists.freedesktop.org>; Tue, 08 Sep 2026 03:27:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788863236; cv=none;
 d=google.com; s=arc-20260327;
 b=iVl4IQyx93Bs5FPuSOEmFp0GLQgPnfN9GKYLf8i0kzCJVu6wqhF86nMpaPn9HVTW4t
 i3dxe0waHocwG7+MB/ZBxp4dRGz1s+UuyAcSjVpY7CcsZTyVxk2Uj3Yeu/e2m15tlaAm
 pkXzGFr4H8DDba3nn8ViEYrpMmDjqGTYUZFQ+q6IohyWbwed/etN96aCOP9c2zeoPLAl
 mxlPcjqhg1yUi+oWNWfAX2zZODA0zE2EMf2KsFKhdfu2v/HzpqmgWxhXB7+2RH5V1qmY
 l+MPrpIVu7bmJK6JNe/Kt7i5DOgzOhe/wrDFZenaX7OJG3PKDkxDH1PhlElyvd/ti9uG
 KAag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=z8a//pM/Ql6aGzlfUZAtH3NGbwHwZ/hnr+wzfI3LfTM=;
 fh=pZDGlvE9O/t+8FL2gCFYroU4IVUzFAjRioZJ5Ulm2rs=;
 b=nAeQsf0vvixfe2ezoYKnjWMWXajBoIJu2o0YbFQ+uwnLqIC3MMTtcbOjXPhbKbo4MN
 9N9mJg/TnCBfLR9kS2aY57Wi69ditwfOhYH+fO618P/08jL6BGCqlMhWZcVfZS+Bs7st
 zxTY39kvl5GA0U+a6Dc1JdQCooZVFbjvIfbN6oa1PaZXO4A7zkwcXTf2jee1E2+0Ek6/
 P3LUxhsflLtxrJkN3Q06pssS32oNt20cM72GQCB8KdX0M/uE/vWPnBCpptc7WnTP+snD
 6qCwdaxkpIFL7LwkLNDD5FmWcmVifdnx40kCUnLkr0rl6IqZB+d/TLywcWH3LvWQ/g4P
 N1dw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788863236; x=1789468036; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=z8a//pM/Ql6aGzlfUZAtH3NGbwHwZ/hnr+wzfI3LfTM=;
 b=HJrNuELy0TftLDve0sK2P7IX2rOo83TLwnf7rRXkzMcH+5FdQIjImIFAFVxxj1TOA7
 xL/1q6u348JcFDBfElycJW6a0v/F6dP3MrmOZkiz4DuVn6f0dQy9hyz72kIwbopMbdtC
 ssOZe14y7gKhHT5ne1nLpr7M5rvqdbAH5/jNdqJg57hzVf+wz3djTcAXuzJFZ7l6c48s
 omgqvfGS8Z3ZrtvX71mXjI+pDGV2RkWMi0JPZ67kTGzVyLAuHNQB7+sCnldQfrtzEbrG
 dG8l0sFo/ejES/ZuFtlPjaF1hZGZosR1cebZSXYsGEC89FMVzetKJT+q4hnG+s58XBef
 y0Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788863236; x=1789468036;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=z8a//pM/Ql6aGzlfUZAtH3NGbwHwZ/hnr+wzfI3LfTM=;
 b=Wj2chJ9L/m9aQgMAm5q7Jc9t/g62tCizJq1bjUWg4mPtToejzvpZSxUHF5FuesnzaJ
 /DXW+OvNiPTrvN9D+zaWJRurLzseYiV/AZ6wcbl3B8ol/+YeuYuIWz/zOqy7h6bUS5/s
 piIOWrgId2HO4r2g/J9NAn6mMtCwJg+9e9dMspjQdRHMDil7aaxSzNbDZ0jKClEURlr6
 02H26Nn79H+yzGKch7vMior/wlKAI2poCmoSLz6Js+M7+G5fhALxZWlhPkyu7eHq3awO
 GAeTgVPXOpufybQbyKpECZZjsYSDrWUT9UfzhAdhBtNip8kICNhzI19LAceiYk6rr/hJ
 tsxQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBykPzInhGQ49PGZiDUza3sPksCuwLQa1XzkKw8gSYWC/qmSMNGRwdgu9c2dL29+fL8kkpwUE8WZAvA=@lists.freedesktop.org
X-Gm-Message-State: AFuF++k+VmheKKRPZe1I/suriKReyqtKiIII8t+1BxQj8WnQL8k8b4fj
 x0Pstq/FrZBLGzPHefAXMQ4tKmvZCQ7nGyRY8/FBIsHfToak3WTHFEKAAb8RHaD74DxNS9G3xz2
 EnFJVtmSrDqfPTbEilbw0RpWM9qkHOW8=
X-Gm-Gg: AYBFou3zkX1koj8fW0T6T5pYJVQWeM3mokJB9SEX/CFi4o+BIIu+Tsqi678DUZeXj4d
 NlxcUbtZOgAbidHxdnslOGV1ihs3IRaGR0EA8iAxRQ+JCAn5pVrLA+HbnInlEbJq/DK6jlST7sx
 LTLRSGr9qwWKEvGLKDNKyR6xhweXlzw6y4qBSXlM2XBJtyoZjtWNTccrefzI+Ys67RzFdUH9eaC
 toUQWHsJKLk26MNo+QvxgO1TbZHt253Tzl23l2IKlGNq9Fpq+u8eXARMe/fKBLfMueHZ0DTo/tD
 +nWmDlqynwaZ0RT4kbtQm/GETfEuoMzVJdG3oo3J4s5mLmDJD2TFeitSiCAv1Y5TiA2E2qw84Sa
 LecthC/K5/1gqraUQmJKSX9ltpXqMU1AvyL9FatCx
X-Received: by 2002:a05:620a:234:b0:939:4b31:4669 with SMTP id
 af79cd13be357-93980434d0bmr2329407185a.29.1788863236207; Tue, 08 Sep 2026
 03:27:16 -0700 (PDT)
MIME-Version: 1.0
References: <20260820142802.1342066-2-rodrigo.vivi@intel.com>
 <e48a854b-1240-4fcb-a429-2c02be10da5d@kernel.org>
 <CADnq5_PvMKVbmukOJW9oHK-bw3110eAf97WXfUVi-urhcEGMMg@mail.gmail.com>
In-Reply-To: <CADnq5_PvMKVbmukOJW9oHK-bw3110eAf97WXfUVi-urhcEGMMg@mail.gmail.com>
From: Dave Airlie <airlied@gmail.com>
Date: Tue, 8 Sep 2026 20:27:03 +1000
X-Gm-Features: AcwNN1UdfEqDvqt4h6-mGvR-jvMGVCb1iWb0peyiWxGKDTiEmCJKruGXVCWaOeg
Message-ID: <CAPM=9tws_bMnxt9QVjt4bP_bO9YM5h2n4FtNZMg1p0ZLsrLw5g@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Drop KUnit tests for removed
 parse_hdmi_amd_vsdb()
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Mario Limonciello <superm1@kernel.org>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, 
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 Alex Huang <Alex.Huang2@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Fri, 21 Aug 2026 at 07:30, Alex Deucher <alexdeucher@gmail.com> wrote:
>
> On Thu, Aug 20, 2026 at 3:30=E2=80=AFPM Mario Limonciello <superm1@kernel=
.org> wrote:
> >
> > On 8/20/26 09:28, Rodrigo Vivi wrote:
> > > parse_hdmi_amd_vsdb() was removed when HDMI FreeSync detection moved =
to
> > > the common EDID parser, but its declaration and KUnit tests remained,
> > > breaking modpost:
> > >
> > >    ERROR: modpost: "parse_hdmi_amd_vsdb" [...connector_test.ko] undef=
ined!
> > >
> > > Remove the stale declaration and the three dead test cases.
> > >
> > > Fixes: f65198b3d073 ("drm/amd/display: Use HDMI FreeSync range from c=
ommon EDID parser")
> > > Cc: Alex Huang <Alex.Huang2@amd.com>
> > > Cc: Mario Limonciello <superm1@kernel.org>
> > > Assisted-by: Copilot:Claude-Opus-5
> > > Signed-off-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
> > > ---
> > Thanks this looks correct to me.
> >
> > Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>
> >
> > I'm not sure where we should apply it though, it's from a conflict
> > between drm-misc-next and Alex's drm-next pull.
>
> I'll pull it into my next -fixes PR.

I think this should be merged into drm-misc-next ASAP, since the merge
is in there.

Dave.
