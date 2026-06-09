Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21975CD8CB2
	for <dri-devel@archiver.kernel.org>; Tue,  9 Jun 2026 23:39:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 664D110E3CA;
	Tue,  9 Jun 2026 23:39:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=meta.com header.i=@meta.com header.b="GcJ+PaQl";
	dkim-atps=neutral
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com
 [67.231.153.30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E103B10E3CA
 for <dri-devel@lists.freedesktop.org>; Tue,  9 Jun 2026 23:39:13 +0000 (UTC)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
 by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 659HkVdX3131274
 for <dri-devel@lists.freedesktop.org>; Tue, 9 Jun 2026 16:39:12 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=s2048-2025-q2;
 bh=GJd2gJZmlAgFMCFkHrHwJ2yIaE6MPUQzzzENfnpUb+A=; b=GcJ+PaQlVJQW
 /QiaOOTC0nYPA6Pp1uWg5Nw0lxfOPK46wy3QRjqt6HHI/s8hYflLqOpkQeAGxxLh
 hoyKhwGK2JX4YooWC50qu5EDWSMax2nyL/oD/rrE9huRAKUD3dcFOCQPD6EbqIBe
 /w0OyjcqD5OfnfePJGKHwyaQUFmf3+Tzo3fYXQ5XrBU7OcozGO9AnrRjAwvSdxcY
 Crl7znQ4/d1k0Z7Rho184bTWuJJxHxuMZzLmmMtWby4mzLYkfL9hkRHA6cnRmNak
 77cxz9A7UldkmH6wLB52VlDZREdWuq79DRuezb/llSLMmzA0JKqEm6HamQd79ptg
 ldQYgc2yiw==
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70])
 by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4epqhcj9ng-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 09 Jun 2026 16:39:12 -0700 (PDT)
Received: by mail-ot1-f70.google.com with SMTP id
 46e09a7af769-7e6ed99b9b4so13654824a34.3
 for <dri-devel@lists.freedesktop.org>; Tue, 09 Jun 2026 16:39:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781048352; cv=none;
 d=google.com; s=arc-20240605;
 b=e27uP8buydw8JzIbLp8YqNfdtI5YSJm4gaNj2igGUxdCHPczoG17CRexclVVp2qcG1
 W0Txw/CqwzteE+g2HGQpQS0e8iyDBVLkaR32WyAr/KHz7qtNpKCm507q5BDMVVSuhqdc
 RJaiHFCG6uK+L+gJA3FlJZIfcsvuc5HTISP8Q3QI9tv6dLsZd21s+bV4zND/nfNxyq6K
 AeMA9laRyhvVUIAKg+GYSbIyiswNUkFv+Op/RizkD+mPYbveI2fOwr7Cq9UDDAWW/CF1
 +wzNesHTgiEn4pJ9XUsq+mgAfKDv011pavWRBmhIJY3lcAUL5hPesPt/8AQ1ouw5L9xF
 pBpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version;
 bh=VHRS+sWMPwoxZ0n+tLXpfsQUcezlTBJw4Sj0yHIKfGE=;
 fh=kKAyGQPDMzvaBtg7KWgIu05p1xbG1V0k8jD7OaHBmos=;
 b=MIz9S/xvhaFC4ItA1xQYKvBC0tEn0dMcrjcHs2qHvQghCh5rRkJ3z5ISX7bSH8WH9G
 T7smzqt/EdklOlg/2TiE1BN7WHMuX1Dxpjh0bg+cozCP6z9JzgZ57SwS8PT6DsMySqs+
 EiBt+YU/sSSKTjsa+rjHrZFdH/ybiHbyHY/HIvYFKb1g/TTcre9Lfi3KD0OWxM8IcQgB
 I+PmfIxKUbAbB6Xnyv4Q8GOw+jioirTj6+gqWCJC6IMiEx4DuekkAOttVZuP7McRwuKT
 OPhcK/obPZPSoMkW/gA62ismyJaN/ZGWjnGIsx74OvsmRh+N+odhPN8h4OUenKXxNrJy
 oCbA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781048352; x=1781653152;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=VHRS+sWMPwoxZ0n+tLXpfsQUcezlTBJw4Sj0yHIKfGE=;
 b=EkmbGz10g1rdlXShvqdazkj1CyXkPALNYA8m1IoQLNOeWRrzY44x7ZjWSa0NKaK3Nr
 0smRGS8bbMgfc2DN4RTyJNisb3OuEoDEk3jGvx3K1EGBjqxEv2pcgVSdi3q7mlAVk2Xz
 e1CoxwK1zaUQ67hGBTG0pasgBpkzJ67D9ZNZtpjUW2T8vfbEfXCj1OapCJjTDowURxmh
 ObJxFkaYRxqkvOTmlwIMYq/NPGbTCJjHrcm7T4OIXC6msz23GcQJo2nlOjMxgUHW59e+
 x1Uz8L3jTIte1yq5tJMXNYzIrtUZA6dmhggEQuEghQX0CaBICm4uBYmLhVXD36JWfAx1
 7/6g==
X-Forwarded-Encrypted: i=1;
 AFNElJ+M29e73U6gq4+cThHM8wio1kRphQxi9N0IKBszfgzFMXtCLj+Yyf6cLmpow00hxLaA3Er0Qk5PLOU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx/SUHxIYcBwzYbRCIq4tKRGoB3MpWNeVOO5lkmbM+JrPLCdBWA
 X8rYm7lIGN7gwGXuaPj4Ys4Mfzi/QxmI+wolFb88Jnby9a3keInlthtB01M5N6YK0qE5mAp7LXy
 Unmp8Y061BYwajk2qbr7nYqcAe/YGU9lQA/iFJafdgtCSyY9asL68E1QgGhzzLWyzmhakssZzzR
 SZdL7YCVJStPFKQTX1M3Tb17KPLy4YDPTOlE2u4/fdTc8=
X-Gm-Gg: Acq92OETj+L54OvyQdyFa8Z0wYEQzRLJosgxqSIzAxm3LKfveb+1ecM4gaJlO9JrKxf
 Og/ipM+yrw2IsIR/byobCzTtzmVjh1Ms05Rg9PNcKpzXH4GfaYIBqEZEaV+pEufrduYnM74jGyB
 O1xHRZd0KybEGSJELrqeBdTYUI8ktoHXsIcdLQluRF7c++OlI8j2lSnRV/v4HqfWBTaTYe29sDS
 yeOlJO1jvr5IBCFJmygziCrXfoLGQ==
X-Received: by 2002:a05:6830:6108:b0:7e5:68d0:462d with SMTP id
 46e09a7af769-7e751abe2fdmr3883338a34.19.1781048352064; 
 Tue, 09 Jun 2026 16:39:12 -0700 (PDT)
X-Received: by 2002:a05:6830:6108:b0:7e5:68d0:462d with SMTP id
 46e09a7af769-7e751abe2fdmr3883310a34.19.1781048351521; Tue, 09 Jun 2026
 16:39:11 -0700 (PDT)
MIME-Version: 1.0
References: <20260608185646.4085127-3-zhipingz@meta.com>
 <20260609195612.GA85322@bhelgaas>
In-Reply-To: <20260609195612.GA85322@bhelgaas>
From: Zhiping Zhang <zhipingz@meta.com>
Date: Tue, 9 Jun 2026 16:38:59 -0700
X-Gm-Features: AVVi8CfvpQJ6ajVUxnazmY-1cK1d-x3MxGzuw2_lfYAMYCTtvbg2jMZaGu0O5NM
Message-ID: <CAH3zFs0u7qJ9JsfweOw_r0FqNUpixLvawZKp9pUTcWWQN6nZjw@mail.gmail.com>
Subject: Re: [PATCH v6 2/5] PCI/TPH: expose enabled requester type and
 capability helpers
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Alex Williamson <alex@shazbot.org>, Jason Gunthorpe <jgg@ziepe.ca>,
 Leon Romanovsky <leon@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>,
 Christian Konig <christian.koenig@amd.com>, kvm@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org,
 netdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Keith Busch <kbusch@kernel.org>, Yochai Cohen <yochai@nvidia.com>,
 Yishai Hadas <yishaih@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: 8TSbeEbaahhNvlxQ5mDbjTXm9gvgWW53
X-Authority-Analysis: v=2.4 cv=L4ctheT8 c=1 sm=1 tr=0 ts=6a28a420 cx=c_pps
 a=7uPEO8VhqeOX8vTJ3z8K6Q==:117 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=xtH7KyWI9dI7BmFOsl-x:22
 a=VwQbUJbxAAAA:8 a=VabnemYjAAAA:8 a=1XWaLZrsAAAA:8 a=earV_t7fcAfV2sAEFq0A:9
 a=QEXdDO2ut3YA:10 a=EXS-LbY8YePsIyqnH6vw:22 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA5MDIyNCBTYWx0ZWRfX4UR/+dCR/5xW
 Uwt4Oz9P8Thp6n2iZenLYENwa/ahKDtYwIlw3pKZmJ0qMrT4IwAZ07MZeiEiajFkbY8J4WbpexJ
 2/+TqUwWuQ5B8hXV+8EIwBcleEbbVlOxUKkMVa44gBHlZknYnTO0eK2IXHjFNeW66shrYEL2qYr
 BMEk/apCeY7nrpV37FCpnTo4n5am7JcFpHSekg2ZZfXYM9xpcm9p2Y9TNU9DOhAwIOGvItIe5go
 DRiWzlWEsewUrOj7i6mEE48t/w1beZjZ1tM4n64R9Nm0orEWa02ZuYX3uJ/2gheysp/hWH1iCvR
 jkSpWIrzIOCq+Gr3mYgXsfzrZd8akUGilQrsB9CzvIaeDx/7jQmbl0pbvxb5vOpF2uUoH1y/8Gl
 iTHSsS5QMfsno7lVVYuen+E56NddE7ZypQ21zpp9frq5RKemBLCYZMJfhlwSa8MASoSbBX+EQrE
 1Ajtcd4k5vwu9Uvhz0A==
X-Proofpoint-ORIG-GUID: 8TSbeEbaahhNvlxQ5mDbjTXm9gvgWW53
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-09_04,2026-06-09_02,2025-10-01_01
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

On Tue, Jun 9, 2026 at 12:56=E2=80=AFPM Bjorn Helgaas <helgaas@kernel.org> =
wrote:
>
> >
> On Mon, Jun 08, 2026 at 11:56:39AM -0700, Zhiping Zhang wrote:
> > Add pcie_tph_enabled_req_type() so drivers can query the enabled TPH
> > requester mode without reaching into pci_dev internals, and
> > pcie_tph_supported() so they can test whether the device exposes the
> > PCIe TPH Extended Capability without doing the same.
>
> s/exposes/advertises/
>

ack, will fix in v7.

> > This keeps pci_dev::tph_req_type and pci_dev::tph_cap inside the
> > PCI/TPH code and provides !CONFIG_PCIE_TPH stubs for callers.
>
> Update subject line to match capitalization of history
> (use "git log --oneline drivers/pci/tph.c")
>
> s/expose/Add/ in subject.
>
> ("Expose" suggests that the interfaces already exist and we're just
> exporting them, but these interfaces didn't exist at all before.)
>

ack, thanks for pointing this out!

> > Signed-off-by: Zhiping Zhang <zhipingz@meta.com>
>
> With the above,
>
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
>

Thanks,
Zhiping
