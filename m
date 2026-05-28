Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F4A5CD5BD5
	for <dri-devel@archiver.kernel.org>; Thu, 28 May 2026 04:55:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7E4C310E2C5;
	Thu, 28 May 2026 04:55:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=meta.com header.i=@meta.com header.b="AIyX69k6";
	dkim-atps=neutral
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com
 [67.231.145.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1F07A10E2C5
 for <dri-devel@lists.freedesktop.org>; Thu, 28 May 2026 04:55:36 +0000 (UTC)
Received: from pps.filterd (m0528007.ppops.net [127.0.0.1])
 by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64RKj56X443790
 for <dri-devel@lists.freedesktop.org>; Wed, 27 May 2026 21:55:35 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=s2048-2025-q2;
 bh=CYYXlTA7hFjEhQyRif4MBMndMkIgqNioaptIr/n0Y0M=; b=AIyX69k6A+c9
 mM1a5KjBZFSdIajJE7N6M+mQ7sGkngpIAcWIEq6pqulW9U5nSY+gI6sFNht86O+Z
 2D6jvDhopxPYZ1YE7naoN5Kloh1FC7xqcci30zbsC9zqOK5hXC7sYrpQFtCwvBAF
 CM6JDW47bs/SUBHJiMz/+G0F/SU/VgcW4J5HaITGfovQtixxblrvL48RNOE4hkl4
 QSltZkNb8/8gzsiQJteEhsP1K0aDt00kHUNwGqFqoNzF4bdIzG4nAfjSr3a8Np3W
 FHPEHYqrWlMwWuCKKAYylzQAXpY1Mcpxe88gvgN6QcAwDuFO547/X8h14sWFBIaG
 Xo82qWEcqw==
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72])
 by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4ee7x1t7xg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 27 May 2026 21:55:35 -0700 (PDT)
Received: by mail-ot1-f72.google.com with SMTP id
 46e09a7af769-7e5fc2c387eso6057858a34.2
 for <dri-devel@lists.freedesktop.org>; Wed, 27 May 2026 21:55:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779944135; cv=none;
 d=google.com; s=arc-20240605;
 b=DHwIT0Y2V56z6jZQ/A5emk2Gywqqr20UCnShlIAE6lefyYLaOqjkBTckrq9kPozxJf
 mzRTrUcIHcjJdzIGmyoS2UbqJkurKJ7MWu5dff0+LAfS6zXuromLxs+09k4EFJyatAnk
 9wtUOXljhFHUbYwX5yvtaWfDgrG9t5koh7J4QBiculZAAW43lu3Z94Ta77Ij2DlsQRGU
 jzkSpg6XJ5SxuIDTQObCoRo8mHepwVO8dBA8Ax0O07IQB9w85uA7QS6AHN7ilTuoUlyA
 QFXhMnyMB80/n6DNsoRmqTZWtOCNiW2YnIjvx8THxbVVVO155QKdzy0VDZ6BKrZuo6nq
 bg/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version;
 bh=2lex2yvH679GF+7VuxlXdYUBKG+oUT1Bop2JInZINhU=;
 fh=kDslKygGA8TmcVaQRxdJ2tXAa2gVBL/0MOLAKeDTyJU=;
 b=PPKL+ybE+tE6sKK1P7WyZxGcr/ovGNlj8LDWDJmoIKaqyrW+nQfxYYj6Dq0UhuwxEb
 MvhDKJgfp7dOHFCseUmU9JLcRxEFQU5HxEHDzfPEvYJc+NrZrtzKK1roDpoYRm0iPwxB
 8ojjMBPd3JQy1liRGL6gp21FCP/zi+fB6Ha7xSgzSCTghzrXoEt846L0WUx/cV4zesIO
 dlLIKAN3YyJ5V4hMI4TW6JSVpH/oIAxhBPSEUuJAFoUdQOPGB/luZG4VK1PlLd46I9RB
 vHgZw11spAAl1dG5qtPCdm8PGNcNPCe2nib2PSzNbX82bD3hbXKBP8T2hq4yTIOANpuW
 mXZA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779944135; x=1780548935;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2lex2yvH679GF+7VuxlXdYUBKG+oUT1Bop2JInZINhU=;
 b=O6C3Yf3GXpvfHmtr8qBTe8ypLIgJ0NuXp+NiCzgLE7kLWn5GpX3+45WjVyhkorDlDK
 Sq8F1XFXiaDy9ai7DDMfVkxqjvdwxgZ3lu88ZUjiM9H7cqQwsgzaEBwzrriwDZsxI9lP
 eQiNsty3Ufy/Sc8e1NymV44tl4TwQXMhWyZeWmliMzdOFrB5E5RQ1X/ejryujZX4O53a
 wIGXz5HmORhF64z3NpGG58dsem1ydNHkzBSo7ICHNESzPXIPW1GDUBTU28tjHu5zxAOd
 BNCh/SUUVhJlJMtYILJpNdCZVKjpS/2smLp6V+POCbMfQVonsz6irNJcW51D37Qwnm2O
 R+jQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9YOlcmYruQ5vQuwPTxm91XHCt3LXF+c0vNacxqDQlmp23AXlZSQI//av0qS1au9CBEs/L1EzXBa+E=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyA4eaLHErbpDIl6BWi5AJtWfBU4uv3pvBs09TD7LPBodCGxbZB
 cdt14nR/e9Meu8K2yjEXyGA4aV7/AUcTgweowkkFikTKA3oGRECRbDzfmZQZBxQ42+29lkXlsxj
 kLKewPphVaxwfX91qHsmc3xn5SVNPCtAzJlON/f5zehMsQOS0yEqC0db9iUpCzebMXXNXGk1shg
 aafcRRx5T1rw+qSbgLPOSGd2Po0Pgc+dlWTUXsITpyXbc=
X-Gm-Gg: Acq92OHcmSjtnWUbWc2Gvu2s6YDEuJ8nICSXS59abqI++crStoDW7mLLhNYtgfoVs/e
 N6qcAHRr6Oa/vgoAfCrcuvgN2ug/4VTI4TTJDVcngBda5zeodfgA920MrXCETWBwaHfhqpmq+r9
 1m4bukY6crmeydE0a2q9eNrLMXkAt7toheZrK5+h6hHsd4JlDiaAZRIW+ykQkQKdPGEdyNRhHVi
 6+tiSCXQcBSFiQQhuURzWjm2pcD2qAyjBTNlIOownKUkdFBU60=
X-Received: by 2002:a05:6830:452a:b0:7d9:7209:4378 with SMTP id
 46e09a7af769-7e5fee23f0bmr17184413a34.17.1779944134697; 
 Wed, 27 May 2026 21:55:34 -0700 (PDT)
X-Received: by 2002:a05:6830:452a:b0:7d9:7209:4378 with SMTP id
 46e09a7af769-7e5fee23f0bmr17184388a34.17.1779944134274; Wed, 27 May 2026
 21:55:34 -0700 (PDT)
MIME-Version: 1.0
References: <20260526144401.1485788-1-zhipingz@meta.com>
 <a8cd01ab-d7aa-465d-bfa3-431f78f33ee1@amd.com>
 <20260527121438.GJ2487554@ziepe.ca>
 <ff247643-73e7-44e2-b3d5-8ac0a8efb871@amd.com>
 <20260527123634.GK2487554@ziepe.ca>
 <a5ff1930-e9fb-43f5-82ab-9875d7a28421@amd.com>
In-Reply-To: <a5ff1930-e9fb-43f5-82ab-9875d7a28421@amd.com>
From: Zhiping Zhang <zhipingz@meta.com>
Date: Wed, 27 May 2026 21:55:23 -0700
X-Gm-Features: AVHnY4KjB7ggvEym3yYxunms23zRrE8n2XXaWHSRU_rJj67WeYLMsK98_vs1TJk
Message-ID: <CAH3zFs2KALuHXReLZG_uoqvBBWvBzU6rHKakmt6HBV7PZEsD=w@mail.gmail.com>
Subject: Re: [PATCH v5 0/4] vfio/dma-buf: add TPH support for peer-to-peer
 access
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Alex Williamson <alex@shazbot.org>,
 Leon Romanovsky <leon@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>,
 Bjorn Helgaas <helgaas@kernel.org>, kvm@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org,
 netdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Keith Busch <kbusch@kernel.org>, Yochai Cohen <yochai@nvidia.com>,
 Yishai Hadas <yishaih@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=F4NnsKhN c=1 sm=1 tr=0 ts=6a17cac7 cx=c_pps
 a=+3WqYijBVYhDct2f5Fivkw==:117 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=4h92JMTCafKA-fb_NiOh:22
 a=zd2uoN0lAAAA:8 a=Vls0teBZlVDq3xJ5GeUA:9 a=QEXdDO2ut3YA:10
 a=eYe2g0i6gJ5uXG_o6N4q:22
X-Proofpoint-GUID: AN0aolAZbaH1suL-4KVph2uv2DEleJDk
X-Proofpoint-ORIG-GUID: AN0aolAZbaH1suL-4KVph2uv2DEleJDk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI4MDA0NSBTYWx0ZWRfX6LPnpJTpNBq+
 PxKHlXfy/gqogWHsVFXeRyO8TXIxB7RQ30rsaJTcIVW5JxaCjefLVmFi06JKbumgcBuHSMBb8jH
 20UsogKc7dTfnCEw9a9ARG4dpS+HOUQo+a7Kz83ovUfPokORMuFDJSKLgMTdVp6fgZsWhzZW/CP
 05zoMwwoXI/1ZmT4TGNZWQiaNdxnlUU9BALHXaVGs3k26O5WPn/5SMWC+DptB4aEWaxAioarZx/
 HuuPzPhWdJ4o8P6Ldzzf2D4t9+fHhOjErOSA5+D8eagsWQb+6O+wD7KgLDDWN/zkqKT0gZF+PPX
 B1n8qGdB32KaNGE5dP6IcR9J1RWSeTRv7OZvHI6V3ZJblSMJnWYu8q0InVjobxG+5+htf1BDULJ
 MTUBdC6deYHb7/aL32VW98wjXMwFnbfHGsiVsbMp/48waydOwf8h2OuV6V7uhSn02h38r9EpoX0
 LLb3ntvDeHrRQTGrm4w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-28_01,2026-05-26_03,2025-10-01_01
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

On Wed, May 27, 2026 at 5:53=E2=80=AFAM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> >
> On 5/27/26 14:36, Jason Gunthorpe wrote:
> > On Wed, May 27, 2026 at 02:23:46PM +0200, Christian K=C3=B6nig wrote:
> >
> >> Yeah that's a good point, I should probably rephrase the question.
> >>
> >> I'm aware of how TPH works by adding the extra ST to the TLP.
> >>
> >> But my question is how is that useful to a PCIe endpoint? What is the =
effect of the ST here?
> >
> > TBH I've never heard Meta explain what their device is doing with
> > it. At least it seems to be super important to their device..
>
> Yeah I think at least a brief description of what is going on here would =
be necessary for the review.
>
> Otherwise we have only the info that the exporter wants to give an opaque=
 ST for the importer to use and no technical description what that is good =
for, how to test it etc...
>
> Regards,
> Christian.
>
> >
> > Jason
>

Fair point =E2=80=94 I'll add a couple of paragraphs to the v6 cover letter=
 and the
patch's changelog as well.

The short version: in this series the vfio-pci device is the completer
of the P2P
writes and mlx5 is the requester. As Jason noted, ST semantics on the compl=
eter
are implementation-defined, so only the driver that owns the completer (her=
e,
vfio-pci on behalf of its userspace owner) can hand out a meaningful ST; the
importer treats it as opaque and just places it on the TLP.

Validation occurs at two levels: PCIe analyzer captures on P2P TLPs, and the
 end-to-end P2P workload yields only expected results.

Thanks,
Zhiping
