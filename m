Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15FE1606A327
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 08:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=w4H+xSTx
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0D0D710F96A;
	Wed, 11 Nov 2026 08:22:49 +0000 (UTC)
Received: from mail-oi2-f7.google.com (mail-oi2-f7.google.com [74.125.231.199])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0424A10E378
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 21:25:29 +0000 (UTC)
Received: by mail-oi2-f7.google.com with SMTP id
 5614622812f47-4b39374fdafso225066b6e.1
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 13:25:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794345928; x=1794950728; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=GPeUEpbxZgN6b6poMbqb4po1OzKA7uw1ryiUgB0GJGA=;
 b=w4H+xSTxK7si/LkUOQWpb6s62zExCQZW2sQH1HPkcBBd0CJXXcJ45jy5i1dzhBdOmY
 dhLDZsdzYDDFNMfmxdhVjEt5LxVCISYI6/kfIUvnWBVMpOvQ+22eyOqqFe5shB5Uu7Fr
 23z44UB+wMuD5EZ0tDl7WBRYOADybu+4AXPFiIA47lG3uP7cYBbVzzJtQN0tzIGyatNs
 L2WuRnOezHBWdIfv2V8p8DB6rrB8nGGLo4VBzSUP+IN7iWmNKijDWjnrot/ElWSPJXCK
 UOkSl7Qtd0V81uQUN0D5wg0boIT2/wJpldLZ3WwjZZZzwcf19aKi7RrUTh7/ktn+VTk3
 xmww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794345928; x=1794950728;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=GPeUEpbxZgN6b6poMbqb4po1OzKA7uw1ryiUgB0GJGA=;
 b=0gZni/VDqYVFighEuoZeq7MIBSM97WtNJa8d83fOwXFhZfJKksbQ5dsZvg0oX19CiM
 Q429pqu9IDVqBk0zWYBW6EXtYBz7vltca1hV7QRGAfdlI36tzzhg1v4QrW7POzfRbXR+
 f+8ff7DU7FB7HXleB5piWFQO3n164PvNyLxztUFr85nPHhzlXjU1aCnyPzLVwpEpJQ5b
 qfhGu9QpO810lj49IJaZ4uGeohEikOfrOx3zk1vF5WwDWt+54+WXWyCM4Il6NpOCHW/+
 80VZQE4YhDmXawWBZ04nAUdpneVCbQcG1bZUPJ+GrYXiEwchpEbOSIU1lhyURw71A9pD
 pjQg==
X-Forwarded-Encrypted: i=1;
 AL+hErHIhNOwaOPZ7Q/I8cL8oIKZ3qQMRsCRKEyK+tmGowxBTuM1taGBTeDB+yQUSgfT8QqjpCfsww1Af4Q=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8CZMzndmfTtcXbBPxwPT0OIOtsJFaBvt/w3iGlBwOXeCY3mfk1
 jgN8Q9asT2B2UW0aAi3EzEnvNM1Hq3yMrZWiJZR11TCtRcjpq8+gTWNK
X-Gm-Gg: AYBFou1mdQZpK1SKJbqQaMFqOaTYAp4nEgZh6m0jSaM3uYTh0g9eqY2i3LaE9pvloHj
 a/ueqaJ+y8jYgHAOd/++R4+EapbGQy9wEqD42khVEvOAQEeWnjhc1dGBLkLpGHF3LkILQEOuWYa
 V1CvfwrqYqlFmQXqw/RUEwK/Vrk4ByT51Q7T7CdYoc5RJiu1YsYom7a7Hp/Pse1DJ+AsbCHqdKo
 R612nUV9C2hkbmYY9sJmFvhUJH1+vv45s4anzVw08DRS81PdTKDO69g+E95FGpbj/vnxGLGVGDs
 v03dzS4mj1DxhWrK5VxLyll+2gopyTallVTsVBPvSb8SZRLooXwz3UfKXAsFAeXNtLY/4TSaL9Q
 yhlryan8plawXbBQ2KpcTaBwkZBP6JN0KwBs+n6ada2YSFXnvasAIfeLtbLD0avIMJQfevY9JgC
 /8pIsOwC8Tk2uSqojTsfVJk0CpwV9gNDQM6JpULcDF8l+Vg2kUGiS3Sj4Q1WSv8QRIRW7kSF+l9
 /vfPkYRHo21y63b8bYQdBgBHQuXnSrL2X9aUZNa0k9YlvCbdvRTeqZtoxcz8oC2RKffdYg/aYV3
 dmnqwsvVXge0ImYdi6UBw63dr/JazCnwrnGrwFlqHReVudB5rZRt3nxivpQQ9sb01Sw=
X-Received: by 2002:a05:6808:15a5:b0:4b3:3e1:499b with SMTP id
 5614622812f47-56b96294badmr126559b6e.6.1794345928215; 
 Tue, 10 Nov 2026 13:25:28 -0800 (PST)
Received: from ?IPV6:2600:8804:5716:d800::f01a? ([2600:8804:5716:d800::f01a])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-5690504c276sm3233400b6e.4.2026.11.10.13.25.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Nov 2026 13:25:26 -0800 (PST)
Message-ID: <01f512c1-84ea-4443-99c5-f6c30242d4bb@gmail.com>
Date: Tue, 10 Nov 2026 15:25:25 -0600
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] pci: Add broken-GPE quirk for some Lenovo Legions with
 Nvidia GPUs
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: "Derek J. Clark" <derekjohn.clark@gmail.com>,
 Mark Pearson <mpearson-lenovo@squebb.ca>, Timur Tabi <ttabi@nvidia.com>,
 John Hubbard <jhubbard@nvidia.com>, linux-pci@vger.kernel.org,
 dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Lyude Paul <lyude@redhat.com>
References: <20261110-broken-gpe-legion-v4-1-c672bb1c4d91@gmail.com>
Content-Language: en-US
From: Ryan Brue <ryanbrue.dev@gmail.com>
In-Reply-To: <20261110-broken-gpe-legion-v4-1-c672bb1c4d91@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Wed, 11 Nov 2026 08:22:47 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

So sorry all, I accidentally double-sent with b4. Please disregard this 
duplicate.
