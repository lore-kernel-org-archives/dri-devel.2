Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC5D2606A333
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 09:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lwHdxDny
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 45AF7112C74;
	Fri,  6 Nov 2026 09:19:12 +0000 (UTC)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com
 [209.85.128.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3454910FFA0
 for <dri-devel@lists.freedesktop.org>; Wed,  4 Nov 2026 23:15:42 +0000 (UTC)
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-4a20bdaf39cso13044495e9.1
 for <dri-devel@lists.freedesktop.org>; Wed, 04 Nov 2026 15:15:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793834140; x=1794438940; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Jw1A1CrCQXufCGBVmtCdk6Ioy3GBOtyXllOzk3wnD2c=;
 b=lwHdxDnyWmHkegJtuhnlp7l7P6hxXyALkZj8/aEu0Gkp4KzszgC+7j2GQ7PLVFg8/d
 uXo6zmkUyAKgcRi/OB4i9tu5QANUmMMD/D8Xgnaaoi7/i3PPqqN81JykeoyjBaGXIZV/
 2YdUcpGK4t11k2FXG0MdZRxUz+mcsO9KP23D9OXL7UTAwoei1hLK+rP2qOFef0tQQOjW
 sKvD6xU6hbKQ6u1f8Vncq7PMkiXykh/P94D5PvrlmzvH+eeXYCj+IYPnj1sdgln2WGO5
 AqkBcbDMj3dXXTPSc5AiqU+TVfLqzuMMadwgy3FM3IVVihBg7BXiGAewwlCC7kBtgQeL
 7Fwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793834140; x=1794438940;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Jw1A1CrCQXufCGBVmtCdk6Ioy3GBOtyXllOzk3wnD2c=;
 b=cH/zNB6Glt7CkBPsyTITAMJ1gCxcgeFHzJxu8M6icrwbvh0WByPoxnNe8wTNEeEHTw
 ycYf4qH7hopLOkmbgxpT9RVfOBb6PcK1gWp1sUo5uKyuxDXbNeehu+WlRQUjTFZuNOnE
 Iko1eKLLolIYW1zxUH4k4xGeu8GpExUOrk+L4n2PkWjaOm+IqMQ0M2jDW9rwTOXIjdYz
 Wpqj9frlqd4hHU0StyJJKNZZedTNnEOLQ803CYrIsAyS3d+dp/BVb7i8wIcOXSLSoW7N
 1VRO+S6lU23JceTM5H+fBMW2JVCSBvGwgUIS3kZ9aAbIjlCTqk/Od1qHLxDLwPtdUTFt
 s9CA==
X-Forwarded-Encrypted: i=1;
 AKwUvByS38Bnw8bYYRBhWPRhBeQBcVwTPU3MA2kxx5YTofwPH4g1PuMy5mNSs0wTa4f9kskb0MkCxHas4OY=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/Xi20TsZL4yq092P3UQ9wUEHuYZpBDCC6FVaohSB34IQ7BSWCz
 +lHp2MYPhq52cemyzeHrIM/IH0oJW63RHS63tknULc8zVOYyq9YsdrDI
X-Gm-Gg: AYBFou22IbqaRhiNI5FTI+jFzO64PwbdSEhyTCrlsbxF2kfwOGaO6AnR7mX0klgwoxD
 T4vZdxoPtT2iNH9G0njRWhEYaybRW7kxk8g8QiR+FicVyffXoJe/+CMtwhQVjhDsl/t3dtZDjkV
 3qzvIphoK5SBxQWZtWw6IW8fHROK4nbGiy20kmF/UNY0o8hoOTbtPoY17hTUMoCkrbMQWuPBCSw
 1QiYoaZtgExsY/NXDx8XvZaV9J5CmmLx2t4yuRvgOuTJQp4/4N8KXAwaOP9+aIcAlnRYNhK94Ak
 RcKEPhhsavVW6lfTLvoQTSlus97sFbH5XcxaZE7cLDt8Ou+Y3ZzIOaxgdJrtRQDdLToLL61m+Wh
 vl+PBJqVbS2XIDS3Ohdq/OAuKedDTzoSuMw60LFOUtLSZdwPLGFeV79vWig4TUuN7hjZprDUABw
 JE79zfr8eThOHesjOJEpMIzTUSdvU1LIaq+jyds9TeP0CXB7G1Dqy62jpGxg5UTtt4716ek1wLC
 vMm+AyPZZ123YvabWITbdeBNxuE98rPvdhWWw+IOkXHBSftTK3I9c6lsHEsW56byPKUHZszuhWP
 QqyoXDS3HKFhkUi0GL3dY8A=
X-Received: by 2002:a05:600c:3f0a:b0:4a1:d8fc:8165 with SMTP id
 5b1f17b1804b1-4b3c3545341mr83410955e9.20.1793834140542; 
 Wed, 04 Nov 2026 15:15:40 -0800 (PST)
Received: from [192.168.1.22] ([83.231.69.9]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48feda20567sm6769827f8f.51.2026.11.04.15.15.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Nov 2026 15:15:40 -0800 (PST)
Message-ID: <ad6e93c7-203e-470f-804b-fbf7ac9890f2@gmail.com>
Date: Thu, 5 Nov 2026 00:15:38 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/4] selftests/mm: test fork of PMD-mapped shmem THPs
To: Konstantin Khorenko <khorenko@virtuozzo.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 "David Hildenbrand (Arm)" <david@kernel.org>, Zi Yan <ziy@nvidia.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R. Howlett" <liam@infradead.org>, Nico Pache <nico.pache@linux.dev>,
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>,
 Usama Arif <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>,
 Peter Xu <peterx@redhat.com>
Cc: Alex Williamson <alex@shazbot.org>, kvm@vger.kernel.org,
 =?UTF-8?Q?Lo=C3=AFc_Molinari?= <loic.molinari@collabora.com>,
 Lorenzo Stoakes <ljs@kernel.org>, Shuah Khan <shuah@kernel.org>,
 linux-kselftest@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
 linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>
References: <20261104-b4-prep-vstor-149847-copy_huge_pmd-recheck-special-pmd-v5-0-c56d0d26f970@virtuozzo.com>
 <20261104-b4-prep-vstor-149847-copy_huge_pmd-recheck-special-pmd-v5-4-c56d0d26f970@virtuozzo.com>
Content-Language: en-US
From: "Jose A. Perez de Azpillaga" <azpijr@gmail.com>
In-Reply-To: <20261104-b4-prep-vstor-149847-copy_huge_pmd-recheck-special-pmd-v5-4-c56d0d26f970@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Fri, 06 Nov 2026 09:18:40 +0000
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

On 11/4/26 9:40 PM, Konstantin Khorenko wrote:
> +	pmdsize = read_pmd_pagesize();

read_pmd_pagesize() is pmd_psize() in mm-new since 5d123bb07b18
("kselftest: mm: rename read_pmd_pagesize() to pmd_psize()"), so this
won't build there, will it?

-- 
cheers,
jose a. p-a
