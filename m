Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26A28CA5FB3
	for <dri-devel@archiver.kernel.org>; Thu,  1 Oct 2026 06:52:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DBF9C10F575;
	Thu,  1 Oct 2026 06:52:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="oDOAon48";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="oDOAon48";
	dkim-atps=neutral
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazon11011002.outbound.protection.outlook.com [52.101.70.2])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4CECE10F1F3
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 17:41:18 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=FHG7WoDlsyJkkNfrqFYc0MoypILyDHCw6w77GXM2ouy+k8qoKouh14YsEToMu/E78CkBJ9XPLlzH5Ysu2GEoUZhRj2H9d6PdTXDBWz5w6v4HqM+Frr4WhFawBNC5irO1g7J0JJZuxm8gTtnczhj1tUK5+bwuZJ7cbnJaxEQr7ZXVw/T0SfGtcIG8exXcA0TSKDABZxHsHInwkgI/5yZxKw1dJQwmy6OYsY4Q1GgnAW8AVz7iLs+VH7T2pVrm9dbZ83wvyFVHVi1D9x2oUnl6kL+Nchc6RfZ0Z9TjHqr08F8T7bCeBJATZgsQevIF0qV+EjVMLxu3WeynQ8K512VrFA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6Dj3mza0d7acfswRMgXyXAp0FLYQUvs4v9I7WURo1EM=;
 b=sv95lef70ro8XOidHE2tbHzb1Bqerj6fH5L4lkXKqu08sfIeyZislfFX+FwH6dzN63QX5SnAdACQD7nDdHCIn2sqZ0fLnokTdnefJn5Jo8iK753eBVFHHfYBOaAVeHjGsPT4sAsvbNGNJoV5KaftEIB2VNckZpD7S8W4NBSK4w/hPl5+MvM2IaUO13vA9P3DlQmw2aurbW/8BbcnqoJSs7rWICa7JeEbkObZzrW+xOfw7G2ig+PxPW2jPTdm0ka49L2OUJWqhHQr7B01/3fbGisrDswUSfAiNh5xG69aMsqIU1VAH9Lt+Qd0ymBNdC2ET2cGNUihqg89R14Q7lG9SA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=linux.dev smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Dj3mza0d7acfswRMgXyXAp0FLYQUvs4v9I7WURo1EM=;
 b=oDOAon48OeBS6pTAWmIZUiQfOFqJqq0xC/o9Tw0s5gOjXQnDoL+hPmSOeIkUgQpL+YkpspeF+nomKaA5eICb+l8wbbqFVNLMc+h2jYeZCLL8eWRyN5teXiYFyGCxF3PiWxHeWL27e/t/Lx4Wc8Ar2gbhQeb+jWPPxZ9fx1sWosc=
Received: from DU2PR04CA0048.eurprd04.prod.outlook.com (2603:10a6:10:234::23)
 by AS4PR08MB7630.eurprd08.prod.outlook.com (2603:10a6:20b:4cd::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.14; Wed, 30 Sep
 2026 17:41:12 +0000
Received: from DU2PEPF00028D0E.eurprd03.prod.outlook.com
 (2603:10a6:10:234:cafe::42) by DU2PR04CA0048.outlook.office365.com
 (2603:10a6:10:234::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.15 via Frontend Transport; Wed,
 30 Sep 2026 17:41:12 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 4.158.2.129) smtp.mailfrom=arm.com;
 dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DU2PEPF00028D0E.mail.protection.outlook.com (10.167.242.22) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.14
 via Frontend Transport; Wed, 30 Sep 2026 17:41:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MUZQb3FAg7yfr2Gmy65jr58i8W7Vn13ARnWdNaUoxX4nsvwmwZAYBAvK52SM7RPBMA2jLKTeQjot5JDkgVcSPC0SS8AwTnJk98aLdlWmxhB5rSXOtR9ObN/iQuVdnX9h+nqy3v5PNsCyJlHIxrBuL8X0wN46uF7tSgaiHR6juqe3StVFe6EsN4NDOC1bxNmKJXhedpIAypEaraZX1M3DGRFk242WiBT7OFtCCP7JdLl0ExLB8cgNGhE/KrUI/Tt0BztagRXiX1POKo2JsuG+t/qydQMUn72csR4mKdNUwNAWwKN7iFmH3KJGd9CWc3hTXN0c/p7FDr7kHl8F0WvnqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6Dj3mza0d7acfswRMgXyXAp0FLYQUvs4v9I7WURo1EM=;
 b=VLFluQFA4wUPvgWQqHMQT8kDLgBsVRnxlZBM2UP9tj/aZn2yC8vHyHQ6aCyngsOl2jw1YVXg2vvUYrtRFUOjt2qSKRMJRLXwcLedBPPi/rSTLR6a58omQe6iS0Wy2Qy7j+InZjL+X7H7Nsw8dFepQKnkClXmiELQhiy59cz3a6X+33l1HbEA3fUL/r6kGULXPlrpsGNC4yAIchLd9ZWe9jIqgL+PG4kxLz0UfXY+FTQZGUyBohS33RTOyu6lSBqOGBis73hp3IXIcD6+/uVStswqXKLNKazfxIMVc6Wv1dgJGlfQ/NNyoOrvBOlL+Qg2X0od6iYBNk9IrjA4zDEiHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Dj3mza0d7acfswRMgXyXAp0FLYQUvs4v9I7WURo1EM=;
 b=oDOAon48OeBS6pTAWmIZUiQfOFqJqq0xC/o9Tw0s5gOjXQnDoL+hPmSOeIkUgQpL+YkpspeF+nomKaA5eICb+l8wbbqFVNLMc+h2jYeZCLL8eWRyN5teXiYFyGCxF3PiWxHeWL27e/t/Lx4Wc8Ar2gbhQeb+jWPPxZ9fx1sWosc=
Authentication-Results-Original: mx.microsoft.com 1; dkim=none (message not
 signed) header.d=none;dmarc=none action=none header.from=arm.com;
Received: from VI1PR08MB3421.eurprd08.prod.outlook.com (2603:10a6:803:80::16)
 by AS8PR08MB9840.eurprd08.prod.outlook.com (2603:10a6:20b:613::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.7; Wed, 30 Sep
 2026 17:40:33 +0000
Received: from VI1PR08MB3421.eurprd08.prod.outlook.com
 ([fe80::e079:6bd:fbe0:89b4]) by VI1PR08MB3421.eurprd08.prod.outlook.com
 ([fe80::e079:6bd:fbe0:89b4%3]) with mapi id 15.21.0472.012; Wed, 30 Sep 2026
 17:40:33 +0000
Message-ID: <63db3469-82d0-4997-9bcf-31bb3aa59deb@arm.com>
Date: Wed, 30 Sep 2026 18:40:28 +0100
User-Agent: Mozilla Thunderbird
Cc: usama.anjum@arm.com, Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>,
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>,
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, Xu Xin <xu.xin16@zte.com.cn>,
 Chengming Zhou <chengming.zhou@linux.dev>, Jann Horn <jannh@google.com>,
 Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>,
 Pedro Falcato <pfalcato@suse.de>, Arnd Bergmann <arnd@arndb.de>,
 Will Deacon <will@kernel.org>, "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
 Nick Piggin <npiggin@gmail.com>, Peter Zijlstra <peterz@infradead.org>,
 Pasha Tatashin <pasha.tatashin@soleen.com>, Rik van Riel <riel@surriel.com>,
 Harry Yoo <harry@kernel.org>, Lance Yang <lance.yang@linux.dev>,
 Chris Li <chrisl@kernel.org>, Kairui Song <kasong@tencent.com>,
 Kemeng Shi <shikemeng@huaweicloud.com>, Nhat Pham <nphamcs@gmail.com>,
 Baoquan He <baoquan.he@linux.dev>, Barry Song <baohua@kernel.org>,
 Youngjun Park <youngjun.park@lge.com>, Uladzislau Rezki <urezki@gmail.com>,
 Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 Emil Tsalapatis <emil@etsalapatis.com>,
 Ihor Solodrai <ihor.solodrai@linux.dev>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>,
 James Clark <james.clark@linaro.org>, SJ Park <sj@kernel.org>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>,
 Jason Gunthorpe <jgg@ziepe.ca>, John Hubbard <jhubbard@nvidia.com>,
 Peter Xu <peterx@redhat.com>, Leon Romanovsky <leon@kernel.org>,
 Zi Yan <ziy@nvidia.com>, Baolin Wang <baolin.wang@linux.alibaba.com>,
 Nico Pache <nico.pache@linux.dev>, Ryan Roberts <ryan.roberts@arm.com>,
 Dev Jain <dev.jain@arm.com>, Usama Arif <usama.arif@linux.dev>,
 Kiryl Shutsemau <kas@kernel.org>, Andrey Ryabinin <ryabinin.a.a@gmail.com>,
 Alexander Potapenko <glider@google.com>,
 Andrey Konovalov <andreyknvl@gmail.com>, Dmitry Vyukov <dvyukov@google.com>,
 Vincenzo Frascino <vincenzo.frascino@arm.com>,
 Miaohe Lin <linmiaohe@huawei.com>, Naoya Horiguchi
 <nao.horiguchi@gmail.com>, Matthew Brost <matthew.brost@intel.com>,
 Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
 Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>,
 Ying Huang <ying.huang@linux.alibaba.com>,
 Alistair Popple <apopple@nvidia.com>, Dennis Zhou <dennis@kernel.org>,
 Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@gentwo.org>,
 Johannes Weiner <hannes@cmpxchg.org>, Qi Zheng <qi.zheng@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>,
 Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>,
 Wei Xu <weixugc@google.com>, Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, Tvrtko Ursulin
 <tursulin@ursulin.net>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Juergen Gross <jgross@suse.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org,
 linux-perf-users@vger.kernel.org, damon@lists.linux.dev,
 kasan-dev@googlegroups.com, intel-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, xen-devel@lists.xenproject.org
Subject: Re: [PATCH v3 3/9] mm: use hw_pte_t for generic PTE table storage
To: Anshuman Khandual <anshuman.khandual@arm.com>
References: <20260922-pte0-v3-0-5670b8cb9059@arm.com>
 <20260922-pte0-v3-3-5670b8cb9059@arm.com>
 <xzlxdkrjilskjcagnl33eed7ijxrgfhoalmmmq5ks3wgjmkkhi@zchtxpr2amff>
From: Muhammad Usama Anjum <usama.anjum@arm.com>
Content-Language: en-US
In-Reply-To: <xzlxdkrjilskjcagnl33eed7ijxrgfhoalmmmq5ks3wgjmkkhi@zchtxpr2amff>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0267.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:37c::7) To VI1PR08MB3421.eurprd08.prod.outlook.com
 (2603:10a6:803:80::16)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: VI1PR08MB3421:EE_|AS8PR08MB9840:EE_|DU2PEPF00028D0E:EE_|AS4PR08MB7630:EE_
X-MS-Office365-Filtering-Correlation-Id: a01839c7-380c-4528-cea6-08df1f1a043d
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|366016|7416014|376014|23010399003|1800799024|6133799003|22082099003|18002099003|10067099003|56012099006|11063799006|3023799007|4143699003;
X-Microsoft-Antispam-Message-Info-Original: oGI7muJrlZpwF/CpDHEzSDJCtzoqS/F3W423126M4B7XVwwmWQMfuelL6Drv404qx12ulnjM4McoRoH2NEquKYER7GCiXUBW2yAtyKLG5ZfBjfUL99P38usNcVC0HjNO/EWQlAlszKFgqK3QjtoK4jRiTZR7h6q3UCvMmEmJj+Zc9flQRzesGOjw4Bjzlc3JwakYyyuP81YRfDZjr7WXaL/YBEk7WP5Zx6XX8bST7EL+YkcQsAL+jYauBpPQJMJTxHW0+4D6r28jU7hFISb4k5fLhdxsCJMhvjoqyCScUWK2XexS1WeyCKHxbXAiR9Y4lzTTl3bM0wOUObWbYPGoseq1+bd9V+gDvz44n9Z4sZWuclTXfJ797kFqNJ/dPY0hlLRBBtPFczXpxW4Jrwo6fhrvbUxlTKhMYweDNyxCG4hMOWqh3Pr0y8Cb31TKDgfZ4nTLwfT0q+OdTJKI+g3t2OHVEynSCqM+0eNK6RhXhg9pN4QLKVzZrNL/3bJPKMPULVkmlZhCDxhH3d2glFtWSxtnJJjOqVwGHoiEvWxeYzo9pWCj1RGSYhinwWMWpXcHfT1Ts1H82zA8m24Olqxekvt6pCSivv9BdoOTXhQuY5Z51sxkdkvXU/UY5OHdGsaD/0ljbuXWDhq2J61EwuOBFAIVLiLOUXMAB0as2Shst3Q=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:VI1PR08MB3421.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(23010399003)(1800799024)(6133799003)(22082099003)(18002099003)(10067099003)(56012099006)(11063799006)(3023799007)(4143699003);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: ZRh/vaUJ8vPLDwbrpqZLGWjxaIwOvyvt14r+gVvGKmgPPwK2TDTTLFe3d41eOrldXN2Fh6Rlgp30is4w/0Ee+/Iz707w8ulVg8jMkeJmQ9QgGwFHZ5aPzws0sX9jQQk+GVEI8LwKndr1/707rxzO8hbJd1HDaxV8NCyM+pYvcnxP1HNJHpEykUsZ0nxE9BGYRfQ1OVtCbOkU9xW6FoIiOOaiHUJhQJUJf98vL796fhWLRMJ5tWyDNUEy39UrG+G97sssgwv7emKfpTstqUBx5b83Q5zktpXhxsiXlgmkTb7hcUBoY38o6Myeb2CjQybUiRxo5I3mlgrYuef+nXXc+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB9840
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DU2PEPF00028D0E.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 5a3f536c-6b22-4217-dabc-08df1f19ed82
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|82310400026|14060799003|35042699022|376014|7416014|36860700016|3023799007|4143699003|6133799003|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: SKgytdSkUj7hwcsvjpdHMkc2asMS5xdK5YSCOj5lugA3CevTWY2EXn45RkYCo7yKzxM9uWEYT0Zh5YMjOlQLx9QNi0PkqdVWbZOG9WZdnQin6NHlgZ+yl7WoMqRQczOAois7xI8Vv8gSafCXRU8OQ7D6WFMfH2FeLKaDciiKuHr0QFUC9Vyl+kp82iuLvsGWaseaxGPCxvmK9kWGNclxhx5XLbyDAzNVAoqlJdeHXlik/wrvWWuOhRfA+vUhhBQ1oihzowiAe7LC16xvIuIo7edTaIbz1D+1dl+fUJJSdPAO+xV2I76O4d7Fut9EL3PZWHmq/XMDq+zm3qg1LXtbV2AO/9SW46teSttQV5qMdq7wB5spcWJwdMFv41JSR01zR/v0Rcq1ycz8jE0DYEdNOJKzMpyLFXRi++uXIi2zBq9oxxaiYjPHR4RL7iaHlJ+QYaVs918I1ZghgsTxpwO/iYVfctgFCaxuAX1GwJSVIkdjs0iSW2JgRnwhbMMSvXgh8r4NrfIzCJosByfEsdxv7dnYjmmPp9Cc3GkkgHkDQ93eHEhsZR6j7PdwzrDpJa3P8nFfLS0DsLCKTZ40eF2JoMskaSchQ9uK4zh18nDeSVoaccyM9VJW9kQMqnSk6aaNY6kMCxdH6X2PDSDDcq4n8iVLG6EgRZeOYx4wzj3RrH510tEWfhAlZD4/zJrasWkdKTNBbxWHFeNa6wgpDBmwwg==
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(82310400026)(14060799003)(35042699022)(376014)(7416014)(36860700016)(3023799007)(4143699003)(6133799003)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: IJT69D1u6kY/TuDfBcJsGx8ZKFi+thExPqEv3uqVrBN8POeGkWs2xIosQivzXSA+aA3Cg5ZSXBG3vy1T/uijNIl/kx23gsQ6/JZKWn3ozaKUyeUyZz69+kKIP6ygZuHTnMJ//JcW2Djxk2DINOs1Fmotowr/rkY5wLB+H1Af1TugEqZ3YPHkGZ14eKjgxgpYlI6mrYjQcBZWSa8ZEe/hI/hq9zTfrwAKnSQ2AOpfo9ukz+mDheZQH1AnUAM4UIV2dTErBcWrOaTb4X46TvyxTNWIe04jxcQhr3yRhgksy9kVayUOmTBm63Er9pTTh5HByfThlWPBiQ9JbWzaeLaVK4pVVQygKGq95F44WDyT9zoXAmPN9bMhXKpB1C8uWR6Azf98Jh6bCCm2nK+oV2CVxBFR3ij74lRToWSYjCEPaip3Ak8OQHTJzUm8w/AfIr3Z
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 17:41:10.9892 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a01839c7-380c-4528-cea6-08df1f1a043d
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: DU2PEPF00028D0E.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR08MB7630
X-Mailman-Approved-At: Thu, 01 Oct 2026 06:52:04 +0000
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

On 30/09/2026 5:35 am, Anshuman Khandual wrote:
> On Tue, Sep 22, 2026 at 06:12:31PM +0100, Muhammad Usama Anjum wrote:
>> Generic page-table interfaces use pte_t * for both pointers to PTE table
>> storage and pointers to software PTE values. Convert the generic
>> declarations and their MM, fs, and kernel users together so parameters,
>> return types, callbacks, and local pointers that designate table storage
>> use hw_pte_t *.
>>
>> Include linux/pgtable_types.h from headers that expose the converted
>> interfaces. It continues to provide pgprot_t to vmalloc.h through
>> asm/page.h.
>>
>> Keep software PTE values as pte_t and retain pte_t * for value interfaces.
>>
>> No architecture selects ARCH_HAS_HW_PTE_T at this point, so hw_pte_t
>> remains an alias of pte_t and this changes the interface vocabulary without
>> changing representation or behavior.
>>
>> Most of this mechanical conversion was generated with the Coccinelle script
>> included in the cover letter. The script deliberately ignores pte_t *
> 
> Just wondering - should this Coccinelle script that converted all these
> instances be saved inside ./scripts/coccinelle/ for future referene.

Thanks for the suggestion. This script was written for this one-time conversion
and requires manual review to distinguish HW PTE table pointers from SW PTE
pointers. After the conversion, it would not be useful.
(Maybe other arch can use it to do their conversion. But they can always
copy script from the series)

-- 
Thanks,
Usama
