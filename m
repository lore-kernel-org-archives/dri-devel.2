Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43C8BCDE00E
	for <dri-devel@archiver.kernel.org>; Fri, 26 Jun 2026 07:54:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 40BED10F4A6;
	Fri, 26 Jun 2026 07:53:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="GxM3vbWr";
	dkim-atps=neutral
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com
 [209.85.128.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F48710F2C7
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 13:54:39 +0000 (UTC)
Received: by mail-yw1-f172.google.com with SMTP id
 00721157ae682-80236b44a1dso23231317b3.0
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 06:54:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782395678; cv=none;
 d=google.com; s=arc-20260327;
 b=XdYFQ8H01x9RKEIf99JSwZLYztRfuStiopqc2nKxmwYCyz/w1iUiKQ1nWWiroZGdtG
 +Ac8pLcKhF/ShBUx8wz24BEq02fdSQeTDRIDlP4qMqccAEdCj2xzoCtwgWXdbV/4rpLn
 SDEpbTNzzzyqkT6yguyPlrjrBWvhNpl27ZW69spYpt2nRH74V4c/R5iLLgd+LrCqO8gh
 KULJbYm2svb6DeH2z/YQhAzNQT/AsVKQ81Ak6xjF4fexCiE+h6aja2XdXBIA5o0aTj80
 C3ZakEn647T+HhqEOC8Q+pKr6iafRy3yU8YGSP1tTLRA3gEgd9zxBmURQ3jCSdd95WNO
 iZ4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:mime-version:references
 :in-reply-to:dkim-signature;
 bh=7XRVG3OG2OGai7BMvMkmW2H7QvfOOUayHbIKz8xje1Y=;
 fh=L2ZKIvIv3DjSb+To34cCjnCWM9yejDndzy/4UfAIGqY=;
 b=corax8yHPGlnwtsgotqJH2fnvaKBXfnP7no7Eert/eWoWC/JAmRuABl1Nat81kJuKT
 Z0yjZUo9Uvh44U5rJIZqSi3YfYrXzc2Dv2ChCfiQvwr9E95Yfj1EgtQlZw2njkrHXKUn
 DUANkmxxwOaOgpqVb9JLQGeUQPiTLtqawZPL8T/Hmy25AAhz2SV1odqWHlYiSm4Rq4sn
 zHW8/9NwKH7lYdA/TkreutiC2fvi/EZGEg16vLbjeiJPsU5ReJ7RPHlyk9+TqGAGfPXY
 o8yB+LqRLuPSQ8lfI7qYwhuJLTGyNi8FHuA51VOh3rqEZGTM4mZcpvaY45OvnZ1cFzw6
 /k6g==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782395678; x=1783000478; darn=lists.freedesktop.org;
 h=cc:to:subject:message-id:date:from:mime-version:references
 :in-reply-to:from:to:cc:subject:date:message-id:reply-to;
 bh=7XRVG3OG2OGai7BMvMkmW2H7QvfOOUayHbIKz8xje1Y=;
 b=GxM3vbWrdz6WPoxdor78GJPL1F5Ixqpi++WAXwYaalxgs2EwP4/2paXjd3tZgD/O85
 L27VYz6Yy5aRcpxff/Nk74G4eFg1poiK3Gq1uLstNUTd3dil84mrWebrYaDmiW6DIMTK
 FrB/f5uYumr2sfZlIDFOO1fGiTCR473XSZxYRs1Pxj+S24x5uUFFYALvtSWzszgYbOlo
 PbztKDXjZWcvJ6s31zuR1fiV9z/yqxm0osxPx5WjRaXEterXs10MMHonGng5kkw1RBFz
 z0hCfc/FJ32QeGgxoyKSQYECgaQxzlQMi5OSEiSYhyaGgxSrzZ5XMF3Ehm1fa/a8f92q
 P0zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782395678; x=1783000478;
 h=cc:to:subject:message-id:date:from:mime-version:references
 :in-reply-to:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7XRVG3OG2OGai7BMvMkmW2H7QvfOOUayHbIKz8xje1Y=;
 b=lVxXKBrGj0WUlFHrV3K3Ineq7QsWJCRhbBUgUeGoAxf+M42fplGFNYA9JgFAVwxZJw
 UbC7rSBH83kukjHChIXel9Nfol1TFAawAKG1xYdCxCSjUKRDL6nlkbBdjJBVxTDokRec
 yQxO2/WJSyGC+Zu1eD+Z0DZAv+grbc8vpbIz6JI2UQk+nXkxq3bP5L/xTRsMpNsjBXAE
 u45lOiYyG9LOhO4zcywcClR+hGikLNxkFPCCSfXjF40V0rxlbmvKg59gPAespYtX5mbV
 BvkY/oqmD1VO4PosebghT5YMKEF7vMWHLSiQ1hsc+0y6JQbsNhPwv50aSJ27vI8QdrdU
 hsPQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RqDTh/7xmsjBG0wCVNrBAui5Gg+UL+dv6kI8mOiUUglZ1w12fWpfwfm6GIjI1H07U0y7C6V79pZpAA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwgjNrJitbpKRwgjnDvcDWwntwSlurNnP7bBr0td5qyYMZpTJGF
 C5lJheIBGS61pnDSldY9TV7lZ+9yrolMc+WJEr6CE3hp5N5DfY8bv6E49T016No6e4B0NGiGnU3
 BSmdvhJH7Y3N/C9Po5j5d/Vff/6LponM=
X-Gm-Gg: AfdE7ck45KhgSjd9aD4nkeQLK97E49Rp+sFD661HPuKQ+gk/dtt0BGyFv6naq9B8mvD
 MHCOS8KhEqhI2JVbDIZP6jdIUMJwGC4kA7F3oq6ohN1oNJFSkLP+Vr08Vn7+hWTVXJP+YbJk+sO
 k8NwvPNfc4S1gFHys29Q20IRQB5X3Kqdy0ldEwXeE+tZO7z+4uY+jedWG46uydg+z6t2X06TrAq
 qLttjy9JHj9nWD0RfpZTI6vjJPTO8WrlPDzaXkraxQ9gs11c1ny0sdNXU5O/iTGFyDE3ysY4A==
X-Received: by 2002:a05:690c:601:b0:7cf:a117:4ece with SMTP id
 00721157ae682-80a6aa9a701mr24334237b3.10.1782395677680; Thu, 25 Jun 2026
 06:54:37 -0700 (PDT)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST; 
 Thu, 25 Jun 2026 06:54:37 -0700
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST; 
 Thu, 25 Jun 2026 06:54:37 -0700
In-Reply-To: <2026062536-protrude-cufflink-9026@gregkh>
References: <20260625085659.4469-1-alhouseenyousef@gmail.com>
 <2026062536-protrude-cufflink-9026@gregkh>
MIME-Version: 1.0
From: Yousef Alhouseen <alhouseenyousef@gmail.com>
Date: Thu, 25 Jun 2026 06:54:37 -0700
X-Gm-Features: AVVi8CfB6xgxNSJRVg7IHhBqLykN6qmH-xFnKERq2pkqqLxtfb0UcjcnMm6tmx8
Message-ID: <CAMuQ4bUtbJmDqLyipzhd8K4+PJcQ546g1=mF+rR17gZQfARnaw@mail.gmail.com>
Subject: Re: [PATCH 1/3] misc: fastrpc: reject oversized DMA allocations
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Srinivas Kandagatla <srini@kernel.org>,
 Amol Maheshwari <amahesh@qti.qualcomm.com>, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, Arnd Bergmann <arnd@arndb.de>, 
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Fri, 26 Jun 2026 07:53:42 +0000
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

Hi Greg,

I found these by auditing the FastRPC ioctl and invoke paths after
Konrad pointed out that the related fixes should be grouped.

Testing was limited to git diff --check and checkpatch. I don't have
FastRPC hardware, and I could not do an object build in this tree
because bc is missing here.

I'll hold off on more FastRPC changes unless I can back them with a
tighter review and test story.

Thanks,
Yousef

On Thu, 25 Jun 2026 10:48:00 +0100, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> On Thu, Jun 25, 2026 at 10:56:57AM +0200, Yousef Alhouseen wrote:
> > FastRPC keeps invoke and mmap buffer sizes in u64 fields, but coherent
> > DMA allocation takes a size_t. On 32-bit builds, a size above SIZE_MAX
> > can be truncated before allocation while the larger value is still used
> > in the message sent to the DSP.
> >
> > Reject sizes that cannot fit in size_t before allocating the DMA buffer.
> > Also make the inline payload alignment step overflow-aware so a
> > near-U64_MAX accumulator cannot wrap before the later bounds checks.
> >
> > Signed-off-by: Yousef Alhouseen <alhouseenyousef@gmail.com>
> > ---
> > drivers/misc/fastrpc.c | 13 +++++++++++--
> > 1 file changed, 11 insertions(+), 2 deletions(-)
> >
>
> Are you forgetting to include the tool information that you used to
> find/fix all of these issues? And how are they being tested?
>
> thanks,
>
> greg k-h
