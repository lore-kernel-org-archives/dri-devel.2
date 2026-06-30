Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9703C43458
	for <dri-devel@archiver.kernel.org>; Tue, 30 Jun 2026 13:02:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 42FC210E1FA;
	Tue, 30 Jun 2026 13:02:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="b3ElnePM";
	dkim-atps=neutral
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com
 [74.125.82.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 64E3C10E1FA
 for <dri-devel@lists.freedesktop.org>; Tue, 30 Jun 2026 13:02:20 +0000 (UTC)
Received: by mail-dy1-f182.google.com with SMTP id
 5a478bee46e88-30cb5001e5bso278853eec.1
 for <dri-devel@lists.freedesktop.org>; Tue, 30 Jun 2026 06:02:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782824540; cv=none;
 d=google.com; s=arc-20260327;
 b=NZ9FlNIFtFlOP/I3NQhbvSX7Mmg464e9uAjmQiMgxYUnGG0po0iWNETT3xzeeXtR7g
 r/Ow/JMNTmYQBuBk9aOXci/3J5HkLoxRb4YEPHtIGyK5YWse+MwfSl+a+7oSiWIq/rfb
 WHi14hx2ddusYIiGOaPpKCN3pN2c4W9VEfXtCk22dRVC61Hc+qctV2oEMBKtHjXbBKfe
 NTqb5cjcBlb8A9avfj5eKLV/OofxzVQKe9GstqWJQjQjzaBEdAf9oAIpFcUtD1k6cgVV
 BV6FX3LpcY2Wsd4aJ/Tr+pm7zJ8YBKcB9aP9pSEDRuiqRXfbc9FPdynY4s5uZVJ8lsao
 Vz/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=32JdvvqJTtjWcr4BtrKwmZqPpf2cS3llz4s7uLQdovU=;
 fh=cqS/854dxEpKtmqrxm6etnMXNPJV+ep7VU3aegqot6c=;
 b=WyIGClFo26XNMH5nS41W4tTZzcTQ0xXsB4hunqw5OS+UyCOCkD0t5PGBY99X8Ldt3V
 uZZLrBQVWaG/hTDGHj7S/SnThNzd0vrJCs4ygUiuWKTk9HUBzj95Yo8JdfDo3dT1C3vn
 i/xUm+YaQolkPzeguhYKrYR1aqY0DHmVMv5gtvjS7Fs5iGa68q2N8Dob9nDu1fpxhZzr
 h4isKGNoTeuRZ4VHlLTNQSWFhpqDTu6k0FmgPb8ISzmtK4Ns/g8N9IfEO5TzzWsbctDN
 +XMydwGIVJWVRLLD4l4OXTPHRW4r8B6RnxTP7jMzvU7O47g+BES/TGY9UkxYSh9lO+wj
 LfkQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782824540; x=1783429340; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=32JdvvqJTtjWcr4BtrKwmZqPpf2cS3llz4s7uLQdovU=;
 b=b3ElnePMisf4qmCUQbqnjvE+m6AHDWIO1fBHKjOZDPCBGCSDDiPOKOyTLgx8VZF/h2
 h3RIxjkH9BUIGcA5M4cl2HTfQnzjDLbigbBOCCAxaQ82Iq3DSq7U/bB5/FhoNSre9zLV
 8l84yh7KZ1NKi7XkbF3Nj+1Z6jvZGygOWWz5tUXf3v09e8e39v88aA1hbsv75yUCWfwv
 HwL3GFVGSSAfZchkJoU/HZFJb3OX1KkpETN0t/DYLHnQvIvgVpIlLySvnKmkgQ00gDsz
 WHqESIoIndoCE9smOjD6EgpN4Zf48asM0fKpMNzxGuQPghhmb1Eg4a0iybRNoxtXaTrh
 y91Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782824540; x=1783429340;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=32JdvvqJTtjWcr4BtrKwmZqPpf2cS3llz4s7uLQdovU=;
 b=kehGy8kkPh4VF4g6eTCqHynasmfbJVhxZmKPBa+kPUBGvilZC7K3Z9lthw0JPNshnF
 OeY9QTWioupOeLYH+DowDaqkqwxZaRsQ5s2wFpCYyaRVX/4MLgO2kgrjy/H+Pjic8sn9
 gFBQh4lM46VQITsgffUEYHGf6Vu/bbbVWDaYlVod0jS/aPODHCJK1u0Ju7Uga9EwZiQ/
 ROYkzRgmcT3uYk2Q81AwiOfQwjZULbiMe2jH2uE2D9T7l+1cl2aHgDosOaTo0rDHat2f
 oVqpZyHGMZcRspbAgQxNJ9EljOSqID34FXvzbHWPyYHbBmy3DdEbV3k68kdsWIym27Rx
 9lBA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rok3at3nUNx9IRmmMP1EZltchwe74JEGEIfjLUUHkkZVcjcRfeJQUyZnyiCqFGqsCWPMPyE1zrH9Lk=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzGG0PTVUJVxIsmiQanDoNxFttnYF9CRjo/Pdhrq8RETmlMUIuE
 cx6mTD368Llj6ipEg6HV0YyzTcgT12pkX+SIzSiIRMmXlUSt29d7BB73aYKZCSvNuAlUL+2kWjm
 NHknmdmQntIt+1o5PEhB/U8zkXi7uSUs=
X-Gm-Gg: AfdE7cnN33sy6lcdVMDLOe90BDv8cbQu3WlDJrtxBOhqgDuVC0iANl+XULEL9B1VPKm
 poosRqHr+p4nBczaykchVLbn7qi9nkhqcCKYlUIILKtZsBRscdNp6hcmleNpWBU2s1DveYeC+QD
 /9w7ob1QbVz4s/5VObfiGPvkfAMjbejUGwe56QypS1BplGeRIorWQxS86GEn5kgR+fK/sqifztP
 Kk5N4/3e1X3W2tg9WAxDjmPrgj9+VN3swtwLRLH9zZiaP81J4UQIGIcS/qxHPzf6k9C3cvIY/ry
 Wp/ZgTQN+ymr8Gg/ALQCuzb1gJsnZlwPoxoQliR+zu5OTeHoQpc5LNHtqD2VuA+FkSuQJu6TKLI
 ooY38RdJR0+o9
X-Received: by 2002:a05:7300:fd13:b0:30e:b3e5:cc43 with SMTP id
 5a478bee46e88-30ee13cd8b8mr1307107eec.4.1782824538764; Tue, 30 Jun 2026
 06:02:18 -0700 (PDT)
MIME-Version: 1.0
References: <20260626-io_projection-v5-0-d0961471ae50@garyguo.net>
 <DJL2T5XDC53F.3C2QC5L1V2H6@kernel.org>
 <DJLLHI7FIYM0.2YB1QJ6TB8R6T@garyguo.net>
In-Reply-To: <DJLLHI7FIYM0.2YB1QJ6TB8R6T@garyguo.net>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 30 Jun 2026 15:02:06 +0200
X-Gm-Features: AVVi8CdlaW0HC3qcToqh7v3q0JT2Ai7s9vfzaVZXIxvGTDn0q6fiJzf_f2XS20c
Message-ID: <CANiq72==81FEfMxTnUCdrFBtj9fnCnhF6jXgx_eqE-VsLgW9Rw@mail.gmail.com>
Subject: Re: [PATCH v5 00/20] rust: I/O type generalization and projection
To: Gary Guo <gary@garyguo.net>
Cc: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Trevor Gross <tmgross@umich.edu>, Tamir Duberstein <tamird@kernel.org>, 
 =?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 Bjorn Helgaas <bhelgaas@google.com>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Abdiel Janulgue <abdiel.janulgue@gmail.com>,
 Robin Murphy <robin.murphy@arm.com>, 
 Alexandre Courbot <acourbot@nvidia.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 Michal Wilczynski <m.wilczynski@samsung.com>,
 =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>, 
 driver-core@lists.linux.dev, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 linux-pwm@vger.kernel.org, Laura Nao <laura.nao@collabora.com>
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

On Mon, Jun 29, 2026 at 4:15=E2=80=AFPM Gary Guo <gary@garyguo.net> wrote:
>
> Hmm, this looks like a false positive introduced in new version of rustdo=
c.
> I didn't get this with rustdoc 1.85, but do get it in latest rustc, howev=
er the
> generated link is correct despite the warning.
>
> This pattern is used by other code, I'm unsure why it doesn't trigger the=
re.
> Anyhow, the following diff seems to be able to work around the issue.

It seems to me that the issue is this line at the end:

  /// [`include/linux/iosys-map.h`](srctree/include/linux/iosys-map.h)

should have been:

  /// [`include/linux/iosys-map.h`]: srctree/include/linux/iosys-map.h

i.e. not a false positive.

Or do you mean something else?

Cheers,
Miguel
