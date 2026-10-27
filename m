Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD836606A31B
	for <dri-devel@archiver.kernel.org>; Tue, 27 Oct 2026 08:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=WYhHJZM3
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0B2CD10E1F4;
	Tue, 27 Oct 2026 08:29:41 +0000 (UTC)
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B013310E23D
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 08:29:34 +0000 (UTC)
Received: by mail-dl1-f49.google.com with SMTP id
 a92af1059eb24-1438d9363fbso724659c88.0
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 01:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1793089774; x=1793694574; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=MGzHH13ZWFaAze8jomr5kn6NEKQkF5IKK+VbX0oc3KM=;
 b=WYhHJZM387dqAG1gQ31yTFQwdzQv+cXGXsCQ2WX0uhjW9dG2cip9RxYgf0j5rIfBK/
 ilPnC08Ui+VTWFZSawV8xxNe77c4jDHCwPFZXNQl+ahee7s/HrsfIlX2vS97vNZJ3kiB
 dBo5LHBRjwsISYZO1iuI/MCTyCvP5j/0fRhp4I+vEHdxhKXONDZMxzWXiM0vg9mufPf0
 mlkuD2Wo9vrBTeMnebxuauDCR6xYmgrPlsVYe8edgvb9aFfVIV0T7NbHLLJbMhmfcRMX
 YPaOrbb0v8Xn+pxG+9Qi7Fc3hRXrkpkHxpJRoziHcujpmH3oH7PieetxXRoHglp3v+uS
 sg3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793089774; x=1793694574;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=MGzHH13ZWFaAze8jomr5kn6NEKQkF5IKK+VbX0oc3KM=;
 b=TmO0q+71gKGqxq+C0Cxn9jE/D3gjCBU0el9xqDPZQzDiDgcm3Ne+enUQz/0lj6vu8d
 g2iUlafxfDkVC3mmZ0zN0l60bZzUxOzPCbt1KJZUdBAkp2AMd/PCFSG03w+x8HvXFifB
 VulyMzYrEbwh+UApU5BxFa6TZ9xH231fnMviSGp8YRMFdq+nK7DGWcTTSYk32YzJDmfW
 1kI5+LwtFAijTTUwYqyFuOgiNoOoP3fYc990eJzTMpJBpQ+X0UpLGMw5OBApgi7hT9Mm
 6rvfWJ+Qd2bd7UO1e8fREZQrKhMzoqbPQgnmsr0QDtGtNvdrPK2hXmuKhP9HUcrj/Z8Q
 fOdA==
X-Forwarded-Encrypted: i=1;
 AKwUvByD+6eQNSl2ZqGjXw1YAoeSw6NZO5KvyCb3O6Ttnkatq/Tbyn424Mdjz7DLK0UFJd6hEkI6qSnfxp8=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJ85sIdBNVUWv4n2AHIiSPG9D7uQLfheGzEAUibBTo9PMWga7Co
 7CGUZHe0SnzKNdDo9MqhK64BXKQxXCEN9pCCQjqLCfBrZjW2Dwdcrqg=
X-Gm-Gg: AYBFou3igWOb2+Ppq4MNmwnfs4t7oYTBEOpySaa1pXcPK7Ie+Cf7xeQvWOT3Ltk+i0g
 bJAdvaLHZ5hi52lHOuojqflNXkN6eJaa6GM5Iwhwr6VTZQk20pakMzvdy6JQY48zT4nF24W8HFZ
 zg0hsGFSK8a6fBuYZzYurYj9Jz+z3TAQtXPrJgVVE2GOIFBh+f4Rut3ttbTRo8RS9sYRAI0IByU
 9K2D/04Q8Nlwfu5FALu+dAiVmPahcNViG91MURa+MLxmYerlJlgM2LGhmUAlWZJhan7vRMp1Zhm
 SGd7x3oOg9QJl+M/RcSXoOe02pLu0DyajJG7AanWX1i/U14UIgyfJ6sdVJOK5Dj25U8zEESwMav
 9rtD4v0EPlGn9rkH4GZGkoPRt9cgCNWiZfvPB+jlppYol8M+ND+QNTsNaBDkDVJ5NWuyLLIx6Nl
 tbyg2NOri+bKOvdNdNrV4N8nsXtCpDs/JWBrCpBtnX9yAx20hn8+1mv9xcEotVsKTqc0z47Ta4+
 PK5XifN9U0Qh93TQ4tcVk50Rao9Vh0AdjY/3CJQgmYDIPtlhkEakthJWlJC35vFPSzfnNsUVDKg
 gsmBeizPqi2+
X-Received: by 2002:a05:7022:eb51:10b0:144:eb3f:563a with SMTP id
 a92af1059eb24-1a3c84c3867mr2805885c88.15.1793089773456; 
 Tue, 27 Oct 2026 01:29:33 -0700 (PDT)
Received: from at-Standard-PC-Q35-ICH9-2009 ([27.60.26.239])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-369e8db7b23sm43895151eec.19.2026.10.27.01.29.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2026 01:29:32 -0700 (PDT)
From: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
To: alexdeucher@gmail.com
Cc: airlied@gmail.com, alexander.deucher@amd.com,
 amd-gfx@lists.freedesktop.org, atharvatiwarilinuxdev@gmail.com,
 bhelgaas@google.com, bp@alien8.de, christian.koenig@amd.com,
 dave.hansen@linux.intel.com, dev@deq.rocks,
 dri-devel@lists.freedesktop.org, hansg@kernel.org, harry.wentland@amd.com,
 hpa@zytor.com, ilpo.jarvinen@linux.intel.com, kenneth.feng@amd.com,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, mingo@redhat.com,
 platform-driver-x86@vger.kernel.org, simona@ffwll.ch, siqueira@igalia.com,
 sunpeng.li@amd.com, tglx@kernel.org, x86@kernel.org
Subject: Re: [PATCH 10/13] drm/amdgpu: Catch register access while GMUX keeps
 the GPU off
Date: Tue, 27 Oct 2026 04:29:13 -0400
Message-ID: <20261027082913.8002-1-atharvatiwarilinuxdev@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <CADnq5_O2tEUHOcbiKL8c4UHpy3AmOWtmM7A8o3jP2qLwkx2jUQ@mail.gmail.com>
References: <CADnq5_O2tEUHOcbiKL8c4UHpy3AmOWtmM7A8o3jP2qLwkx2jUQ@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

> You can drop this.  Nothing about this is GMUX specific.

I agree, but there needs to be another variable. Using pm_runtime_suspended
or using any other pm function will not work, as amdgpu_pmops_runtime_resume
also requires hardware access and even though hardware is accessable by then
pm core will show that its runtime suspended.

