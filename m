Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 715D3606A328
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 09:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ws7thbfs
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA28F112C81;
	Fri,  6 Nov 2026 09:20:37 +0000 (UTC)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com
 [209.85.128.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E8AD710E3B0
 for <dri-devel@lists.freedesktop.org>; Wed,  4 Nov 2026 22:57:51 +0000 (UTC)
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-4a20bde60a0so11070975e9.3
 for <dri-devel@lists.freedesktop.org>; Wed, 04 Nov 2026 14:57:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793833070; x=1794437870; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=bZmm/fjciQHFDsHygF6gqzElYGHv0HpumcgfM0NGUjo=;
 b=ws7thbfs0JV74O32t+ul3lXt2SFuxu3uDBJHYc88l7S12ZkhsDQrZh3KlUFauiIcwP
 IYSg4pehmZGpo1YdcarKVQ/ihjZetRuASMsbzQDYxqYsSHP8AzY0vCXx86hO3fEpyf5U
 JopeOjTsprxFQH06dDR6L0qwQxx3VMMxY2aA6xGToTfyPXGnZOvGJwzQUeLGGVEfWvnc
 WAUkuOmPYewkybZ5C6X1dKMyaZrHV80jsNkxyVRXmvVWq5cgNlsIjSHfmnPWMf5A/h96
 5ClEFpFeVqpHg5m390mgDSP/X22XwhkKga1F51FkDWoiuuS1aYQtjmGeSzZGP1Kul5fK
 B8Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793833070; x=1794437870;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=bZmm/fjciQHFDsHygF6gqzElYGHv0HpumcgfM0NGUjo=;
 b=N1/hK4BGA6AO+fr1Vq4eYhhYjWSoVkX8Th/188WFqiElfKyhW58VQRyOUx4cEmd43M
 OearWZKSrruzU8nBq8rWrXQCvvOMNTo7YPlJv3iWAznF39k71OZ5mjlCYd6VmXMifW02
 u6I5GY6r11U84P6KQKo4EBH3EbTz9Q6zZ8+oF0J/kPDFcKNwtOTP1h+UH57l9gxidSd0
 J7J391I0dFNjMxgkt+Y7mwNbPbK0a7L1+pbsqtGufm+Nvl67PTw3JXyljtnH65Y8WDS1
 gO0k4ttC7oNZPevj6TU2irYg7UghcnkB4GmBkbQnBNUNnl3hV73tUSlxcte0OHh9HsyM
 aGog==
X-Forwarded-Encrypted: i=1;
 AKwUvBy5TLmbjJ7V+ccIQD5jgSvvQ33uvWYDFnH+eTLjxN6aOpNYSzWfTqTsCyIhbVqrY4O9xlMra8REGIo=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/c9+juLDnPozqeUjMJfDNGkHp3TvBh4wU+U00cmqIKHlLCFNWb
 xIMNzsXlNy8CZyt+W06BtFHqTs+8dslXZ1yaiDWfzMBUDx0vWx44Gphr
X-Gm-Gg: AYBFou0Cj383PTZYPz2/HB5RR7YleJRWeDyPlxXy9sWefuxJ6WZyHE0CQagKDIyMbY1
 Ci1wLJoUMIFMBPp7m9aLiKp8HhZs/hIvK5l5mEuW6+T8f8Kj5J1Xd+HBUBTOXKQ/bVUaLY00O+H
 yQMYCM6h/FdBrQYrYDzN5YnkGO6Rca6B2F6zOIT1tsRwlPCMagPbdpk9fU8xJaSGE3vA3qCkKGo
 5qygPuYmZwmTOzxvKSIUZJ9cnhHOVWpBpmZc4QL9pidsj7Z+y/QZbm7Ioxui4h5ehUaVi5iapUe
 x/npzitHCDkwwRH+cx2/eVDtgbJvkVku72HGMi6ZOKJ2tn1GvVYTIw34AK0O1iidU4ONHRawK2f
 AaHeRDX2y3AqjLmsmyJqqs6xK6P5atlDVS3hfMyJRHWUg391zvyhq9MYDaigDs4DcdUaUQZjaQM
 PfN56tbs+7C5MADhatSs5N16Za4db9Udqo3mVQnvEt0hWRTMSPJcPkDQcSs+KlQGrE3Bk/YgcUc
 60AofdskqX1k++SNIyORNKKCcNeKsD8O0fXYnrTNlZQopnD2Y7VwVRZ0GNnVciXY2vT/WfND3QQ
 knjur1fleTHsgeBaDKtXTRQ=
X-Received: by 2002:a05:600c:6212:b0:4b0:a7aa:843 with SMTP id
 5b1f17b1804b1-4b0a7aa0a54mr222825565e9.25.1793833070285; 
 Wed, 04 Nov 2026 14:57:50 -0800 (PST)
Received: from [192.168.1.22] ([83.231.69.9]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b5725061e1sm17756545e9.7.2026.11.04.14.57.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Nov 2026 14:57:49 -0800 (PST)
Message-ID: <93d13781-0c37-4a3c-8fca-6f8108eff35a@gmail.com>
Date: Wed, 4 Nov 2026 23:57:47 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/4] mm/rmap: duplicate a PMD mapping as one in
 folio_dup_file_rmap_pmd()
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
 linux-kernel@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>,
 stable@vger.kernel.org
References: <20261104-b4-prep-vstor-149847-copy_huge_pmd-recheck-special-pmd-v5-0-c56d0d26f970@virtuozzo.com>
 <20261104-b4-prep-vstor-149847-copy_huge_pmd-recheck-special-pmd-v5-1-c56d0d26f970@virtuozzo.com>
Content-Language: en-US
From: "Jose A. Perez de Azpillaga" <azpijr@gmail.com>
In-Reply-To: <20261104-b4-prep-vstor-149847-copy_huge_pmd-recheck-special-pmd-v5-1-c56d0d26f970@virtuozzo.com>
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
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/4/26 9:40 PM, Konstantin Khorenko wrote:
> folio_dup_file_rmap_pmd() passes PGTABLE_LEVEL_PTE to
> __folio_dup_file_rmap() for HPAGE_PMD_NR pages, so it adds HPAGE_PMD_NR
> PTE mappings to the folio instead of one PMD mapping.
> 
> The helper has no caller yet, the next patch adds the first one. Pass
> PGTABLE_LEVEL_PMD, as folio_try_dup_anon_rmap_pmd() does.
> 
> Fixes: d8ef5e311d7b ("mm/rmap: convert page_dup_file_rmap() to folio_dup_file_rmap_[pte|ptes|pmd]()")
> Cc: stable@vger.kernel.org
> Reviewed-by: Zi Yan <ziy@nvidia.com>
> Reviewed-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
> Acked-by: David Hildenbrand (Arm) <david@kernel.org>
> Signed-off-by: Konstantin Khorenko <khorenko@virtuozzo.com>

LGTM:

Reviewed-by: Jose A. Perez de Azpillaga <azpijr@gmail.com>

-- 
cheers,
jose a. p-a
