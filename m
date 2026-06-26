Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58358CDE008
	for <dri-devel@archiver.kernel.org>; Fri, 26 Jun 2026 04:56:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D28CE10F416;
	Fri, 26 Jun 2026 04:56:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="B0EF3wbl";
	dkim-atps=neutral
Received: from mail-oo1-f68.google.com (mail-oo1-f68.google.com
 [209.85.161.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BD5C910E2FA
 for <dri-devel@lists.freedesktop.org>; Fri, 26 Jun 2026 04:56:31 +0000 (UTC)
Received: by mail-oo1-f68.google.com with SMTP id
 006d021491bc7-6a11ee16bafso460213eaf.0
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 21:56:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782449791; cv=none;
 d=google.com; s=arc-20260327;
 b=AF5PBmBxlmS2x4L+jKwdYEd2c1uTb3nDEXt2xEmab+l36gOrnfjvOpVhuTU0TqzqdZ
 IZbLFrru+1YvoI7N52yR2aafalVWkyR1rqsPpsnd67+kYj2fGbmJfO9Ydx3HbjHSYIId
 JsnYr6jKQU3Ifvkzaow7tiIjQWEwpfcFUtev+DMjlbbU9/0k92eQbGpD1LahXlOPDty/
 PzxByG85He4irNsvNd7mU+caxrzr3PrXmwxXHyt8abXCKd23KnaXyuFXKcm5nJGfvrXq
 N0FixTNrd641D+BVd2kGsHSfvKehiypY8faAibeemcbOqqo1mEnJ/A5/rLB/Y7glCVNS
 qA7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=TLCDSxTzhM1JO0GFxs3906RW+bAoUMN+D9UfGDqItVw=;
 fh=pq+0IFKQbyqkYPg9eZ3Qmhg6OOWYGNDwE0XiUhCov/k=;
 b=QyVLYclN2hDkxneX29cBEcvoGEcaJr2uZ3c5mkA7nLOC7aHWqdFokuFfp7YzddMlXs
 Q4qJo+eaczl4sDTWuBvLX3BVzwnea8JWe3IdW8npIaibdP4lI3zlFI5a69Qx5XedM8Ld
 iXrxQ2p6Tj9djJ3hOXhoChygD81wkqnWrvQ+t2Xn4VF6HqQkJbWs3FsFO5/DtTr9fljS
 vEFIXNQ40Dself+v8ivAJ7Zpxk1b0Ean8Rgfm3gneGlgZhv0Q8PDo4vhd+QuschbVqa+
 mg+WJ8QP4JQPAZzpT1w3W77NL7xJinLtfTyiliql0ixEj4KsuojTKYQcvHlxBgP25Xg2
 usTw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782449791; x=1783054591; darn=lists.freedesktop.org;
 h=content-transfer-encoding:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TLCDSxTzhM1JO0GFxs3906RW+bAoUMN+D9UfGDqItVw=;
 b=B0EF3wblvGhAUENkJTCpBypuauGf7a1M3Ob9UFmnc3P/6HrOhAl2Gzs8lbGyfjhIWo
 nZU5pvLPWaSN8Zd995i0TiBFzsVMx5Im92y7fkIbKl+oLJcE+gmqJalTm+mF4pTKVISg
 b3KN9dqk7QwQ6pymv8pp8qa0h30t22UX92S85JGJj+rvtw5ZHl0YhTF9EevTB1IRmbUq
 NIDGlZ8YQnMLyRBlKn9krTZRKNc5ghiFgVb8liaj3z18RIYhx2p7dP36HwhLyjN8C70z
 d5f/wXjyHw0eWOqj2EpT0Fzcp6PXm9OL5fLgMHBF9BtM7PKAaHK6HZscSCNs5nCC9z29
 Z+MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782449791; x=1783054591;
 h=content-transfer-encoding:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=TLCDSxTzhM1JO0GFxs3906RW+bAoUMN+D9UfGDqItVw=;
 b=olO0xE5ZuDGtH85Gs5+MvA8NxPX2m7z05J3nbc4wqCthBqgMHHhz/6aRsdhno8lFL8
 qSuOZORqwcfUUY1aVe1yr532SuKVGh+lATl5M4houWHDy6hwMowIdDV8/kR/H7p94nuC
 hJ5j52m2EKhvyJRHYi1Pb8XZDWgJ1ZrfmqGiryVH9iHZp69O7kAAzPc5RvYmQK8zPz2N
 XyXgqMIxpNRpD+LLYBNgdXUbCGH6IToThLzaUVRtT/ugKBp+6rRr/8Ex9a1GmugtncIY
 UMlI9dMsH7Ym/XKKum9f5WwgiU4ZX0sfnhyIDAQ2QtoswjvgL5dSPMtGAS22oe9cSo1J
 83jw==
X-Forwarded-Encrypted: i=1;
 AFNElJ8IxT6nYUkQBDXfhq2JKrLPuCuMr365hOi452rTJ76zalfn5gaGEUKa7+X/lfDd05kgn4FP5Le9q3Y=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwAsEyvAyeDyBQU+p1gRpBMWbiNm8dt/irQQzFE7gG43q+tBnvS
 nVCg80XdOzHBb0AX3fKxh0fb/si+c/u+0d2iahGQ6XdbOcZ1cC/lKVGhq0g6UHNYrT700RiKkH2
 V5iUYrU83pRr6iYxnRlcNjmV/5saD4ysnMz7IsYgjug==
X-Gm-Gg: AfdE7cl75kX3pweX85FMJZ1j4PehpJE4t+e8F/3fiHxylVAc4XkD2Y+F3i+BPFB2hqA
 NYlH6VerGmPt3OmM2nDe4go4EVyx1s1RKoSICnkGdYvFQvfmE5Hjx2i/qD0nVc94setpO0bi4K+
 DF3tv2ohRTkbaj3sWuy9wYhEV94gJr5MjlkmZwVmshULwpoyooQd/uoRZRUchjOStYpE2n43Gux
 xzwJ0cw+TGih7rXi8ToOPsWebojpS4DdYmFEBhDAtJYltIehstjxuP6STaJ8TdyZKcEnC7OA+Ux
 sRlJprHm7esFpoD0eslCRBhU5NsVf68=
X-Received: by 2002:a05:6820:178e:b0:69e:b425:744d with SMTP id
 006d021491bc7-6a135055ad0mr4528390eaf.6.1782449790927; Thu, 25 Jun 2026
 21:56:30 -0700 (PDT)
MIME-Version: 1.0
References: <20260620-ch7218-rfc-v1-b4-v1-1-3412debf44b6@gmail.com>
 <b9256d5f-ac08-46cd-ab84-3fc0e6e52b61@amd.com>
In-Reply-To: <b9256d5f-ac08-46cd-ab84-3fc0e6e52b61@amd.com>
From: Stephen <stevester.codes@gmail.com>
Date: Thu, 25 Jun 2026 22:56:25 -0600
X-Gm-Features: AVVi8Cf64YJ4owdxmkzWNKc4BReuGudKjy14P2Lq_16_tPqhQ4ExlJJJtpbeL-k
Message-ID: <CANC0aFeXLE0j8ukyRS_gzP3uQhJb9xD98+a=jE96Cc4EuNFcmw@mail.gmail.com>
Subject: Re: [PATCH RFC 1/3] drm/amd/display: quirk malformed CH7218 PCON
 topology
To: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
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

Hi George,

This dongle is from Amazon and is described as the "MysRuida USB Type
C to HDMI 2.1 EMI/RFI Braided Cable 0.6ft, 48Gbps,
8K@60Hz/4K@144Hz/2K@240Hz, HDCP2.3/Dynamic
HDR/eARC/VRR/ALLM/DSC1.2/Dolby Atmos/DTS, DP Alt Mode Compatible with
PS5 Xbox Monitor"

Just FYI, these CH7218 USB-C to HDMI 2.1 adapters seem hard to come
by, hence why I purchased this specific one. I=E2=80=99d note that the Vola=
ns
brand one, despite claiming to be CH7218A, is not. Mine was VMM7100. I
suspect the Lindy 43428 may actually be CH7218-based, but I have not
tested that one personally.

The one I tested exposes:
branch_dev_id: 0x2b02f0
branch_dev_name: CH7218

Thanks,
Stephen

On Thu, Jun 25, 2026 at 2:38=E2=80=AFPM George Zhang <george.zhang@amd.com>=
 wrote:
> Hi Stephen, thank you for the patch.
>
> What dongle you are observing this issue on? We are interested in
> reproducing the observed bug.
>
> Thanks,
> George
