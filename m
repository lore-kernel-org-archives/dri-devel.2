Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8A83CC6B34
	for <dri-devel@archiver.kernel.org>; Thu, 15 Oct 2026 13:45:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 10E5810EC0E;
	Thu, 15 Oct 2026 13:45:39 +0000 (UTC)
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com
 [209.85.214.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 023D010EC0E
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 13:45:32 +0000 (UTC)
Received: by mail-pl1-f174.google.com with SMTP id
 d9443c01a7336-2e7e742a2c7so36161765ad.0
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 06:45:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792071932; cv=none;
 d=google.com; s=arc-20260327;
 b=Hl5astvbquDB8vUt+b0vtDKz11i1Pll5X8ueRIUJlzuPFMXHlu5sPvo0dB2TIg5z8H
 fI1Zie5PZsPNFCuGl4YIhXXZgejjVS9LaiamOrivR6pM7QS1fBteU0ZkZmcWa3RHYo3J
 mL0AOPUbFqMhIbzlUrTh6IG2nEOkT2DR24Yj6ZquzUe2TP8OT+yjIZeMKGm4HT3n34u8
 Jic0TXGsgbjnGF9l/bqm8d0yfA0ZuEVG3qrhmNIUG/8sh87l+7Lm+O5O22WO7bZpZhjC
 X5dlsO/9/6eiQRLDSzJYe4sgmcsAIqxm5R0nt/Q7vWcG/YSV/spT58qjvBpJcB4PsQZS
 mVYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=d34ENdl7sUX1mC2XCxpsqQKP7Xbch1vuzKqxkOWiBNk=;
 fh=LiPfUAfdqPkfnxQ6hvcUz6aJuw5JcaiIA/QWmQOoqiM=;
 b=mwvjQ+4zTQtUW2WZC1xTJ1KSuwvraj39nImrjgi6/1G9EDJu1qG+GJU2O32p3KcCV7
 4Ueq/8hV5a2pr+9tzrnMibUA8YaJ9cdNh3BNRjWc33+omEDUunAr/YWNQhLxM4mt25AZ
 dOhF5g9Iv3bZ36PLEgbjl2JC3QDwPjLWOHs1gOTGEL3Eo2e5aLVku6i1mJTfQFl1d5tr
 dcKgPpWcUvPXfbQy/UHuT36vMS8KMRnfADS9wJnn0fp2ge7g4dfolRbNqZkppcU0tMiL
 rfnyv5HOvclniULHE4PwG6DJDl3QNPhg5omj4bmMtXSTVRnSFOGLgMmvbzYb8GQ2+yY6
 xZrg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fooishbar.org; s=google; t=1792071932; x=1792676732;
 darn=lists.freedesktop.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=d34ENdl7sUX1mC2XCxpsqQKP7Xbch1vuzKqxkOWiBNk=;
 b=hl+sZ9pNrcWQbPmGDOoWJm/qHEis7RK1FgBkANJSfnUYFGeEG1NL0fqZl/NSusZY3z
 d61IU9vyab2KkjuLer0H2+n/FaKvUK4ZKs6ZePwq4L9/InXBlUIMO06O8I5FCk+gZGRK
 0ZUgLE4op3rYE9xtjpOtBvR0H1EeTfoKjS5D5xegjl9fiWewxvN/lr1t5zUDLnCzSRB/
 3+f2uoihn0Hn6GGstNzhVfwxGhj8qsJ4sYcGt8I5IsW2Fjb9KrS4WSTGt2aZoAxiZdrL
 zd1S2wPoU27a2t64V+j/Q+Cpw38e8VVLsY4yKQAjGRfPqNilpW4wQZnOs60uDfzHGSGZ
 vf8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792071932; x=1792676732;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=d34ENdl7sUX1mC2XCxpsqQKP7Xbch1vuzKqxkOWiBNk=;
 b=hVW5kPkj7vIzlpLLUoOpY1sFhj1hTWaCS0QteWKcdWu0N8JdlpQgUcnBY5z93/gjzy
 aLg09b7syk3QTJabJM6UmW0SY6Y4p1rohkfQutGFzNC+/Mb0jpJiMoA/q2dmyzjXTpzg
 xJplwPX18iUF8xDinKLGUxXXxVy7/Fy8anBZvfShFsWPxUfiTPUrDs6YHOT/w2MYXpGI
 TPUoq+QvMVt4nWb1cxBMDO6v5yTYLQR9AydjdK3yHUDtn/y9ao4FV/kcs3Pb5gEGyxpD
 tyHr9IJ4HJD/JS2/ee3CdcPm6Hvl6wB9WG6Kcn6bR2pkyRkK1caq6A+7sHCDCklspOv8
 7k6A==
X-Forwarded-Encrypted: i=1;
 AKwUvBw02QJmID0Ex3sS0eXwe9K2FxdLtp1XekfdbtYj56X91LHc1ObiLpqFwRfgnajIKUZx8euIsjfeLZw=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIt83S03SKmrLkr7VCsG0NQSv8okR0js74FxJpWBehcDRdoN/Fl
 5iJkgEfsLdP4wuXLaz8Qy5ljqiMGbpHPDtgQOrjemcErkbTjMGiuz0fN7r/vdwuzGkqR5BQ7IUx
 6ECa5grseoRAJF8LnbO7iPGSKgX32I9Uq4nUubtgFPROvJpsqlxWeoOw=
X-Gm-Gg: AYBFou2Ml9bjV0CDlItppa6A8ZB6iTWDOy0/GeX1HaLzkVXZTIuP65gRxkPf0XdXACL
 0RzKhUeKrOCWv+fxHVC+drQR4USySHg8Op3xuB2kkLAGtmtfGC4mVDJONHBdbx7ojGzWrYXuZp0
 IiK1OWRndA5lWlMyjDJ0DFHvwmCFGV/7Wmx+kKA28XO793OnNmmRxMa+pv2lFId3VBfUwyD1dXS
 1zjUCIH27nEp/wTJtLxhLfUAQ3tpBpPdfGi9tuJxGIKppy0UBt10tWCR1j9p1bnIVTmwPdubgPS
 NtxORiVnTLDQifShFsurm0Dod4RS10PgTKeWXlzZzngzafUTsFhcqgY=
X-Received: by 2002:a17:903:15c8:b0:2e9:29ec:f894 with SMTP id
 d9443c01a7336-2e97756f34dmr280475ad.31.1792071932367; Thu, 15 Oct 2026
 06:45:32 -0700 (PDT)
MIME-Version: 1.0
References: <20261015131301.711153-1-daniels@collabora.com>
 <20261015131301.711153-3-daniels@collabora.com>
 <sashiko-outbox-172908@kernel.org>
In-Reply-To: <sashiko-outbox-172908@kernel.org>
From: Daniel Stone <daniel@fooishbar.org>
Date: Thu, 15 Oct 2026 14:45:20 +0100
X-Gm-Features: AclHuK8waALSrdB4EhLPtv8GlX23W-lExWqq8q2cI2vUC4GU2EE7toXsccGM2Ac
Message-ID: <CAPj87rN_iucmsrZhNK=xNgZrOSxBcmHEm9hEkwQn10LQQsj24A@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/panthor: Delegate neural power domain to CSF when
 present
To: sashiko-reviews@lists.linux.dev
Cc: Daniel Stone <daniels@collabora.com>, dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
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

On Thu, 15 Oct 2026 at 14:18, <sashiko-bot@kernel.org> wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
> - [Medium] panthor: resource leak due to incorrect LIFO label ordering in error path
> - [Medium] panthor: incorrect hardware teardown order and duplicate TILER power-off
> - [Low] panthor: build failure due to returning a label identifier

Well, that's tremendously embarrassing. Will follow up with v2 sent
from the branch that both builds and works, not the one full of rebase
detritus.
