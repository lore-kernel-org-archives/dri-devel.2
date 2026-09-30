Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E1BECA5FB3
	for <dri-devel@archiver.kernel.org>; Thu,  1 Oct 2026 06:52:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2B8CE10F580;
	Thu,  1 Oct 2026 06:52:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="e5YpwPeH";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="e5YpwPeH";
	dkim-atps=neutral
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazon11013017.outbound.protection.outlook.com [52.101.72.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BB70810F1F3
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 17:46:59 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=PQKxYcQH4nbNgXfMzBB+Do2cstm2cOU1t31Co2UdQjqBRhLANWjtDjQ3lc4w2BkzWdqO2TQhEV0wtqJwkuModjpxrcXVZdTqhCNSOCu0oY9rRMdELSkbJq6o+vvQII+jNx7/drvBAOGslfXWcEj84d+Bg1+kjOX6meyY3w5xlSrM8rYGx96NBAwaVzlpGZiOj/TGmBmqv9EHzZJzNQ65avOqBE8PkO2S00Qq8ov9MHUHaNBgxL6zgAST7TKqZhQtrPq3aGRcxdZXwOqJVkMvcmXJyHjNnRA5Zc/l4kr5J/XzwNIeAyttoBeY2l5DpfbY8IJ7gO/sUb4ip9TrqQ/eQQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9aEn4ubSlfZC8d5zvTQtfBiiaBLSDPSceR3sArTbNzQ=;
 b=OqZD3WLXSbPp6GI00Tv62UOmtfP5awf0bA2haPPon7BS9f+jt9r8iZOQkep1R4s327f7YCM6Ph6YfFUytRhhOrxKtm1Z7+j4qIpDav/fHAzfmCWE8gb4CCvBUHguw9Pztmj184Z7Iu/5ud9UDm+aK1aP2pKsfMJvsLo4pPqOGFGvJe8pNzDnnNxBpv+7aEnbxuWBUGXZkfh3TlEsdDbqns5n6qoKnuSdQROJEsPXNwL/uAIxUqMU/dF5t1U7//0qYx6GnsV4d2kDUYtQ00Ly94FA0zqWEnYTCpIEqgr4XsJPBpxrI7W762ngbQNM6hKTFybasvN3DdhY9RVyfUTx7A==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=linux.dev smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9aEn4ubSlfZC8d5zvTQtfBiiaBLSDPSceR3sArTbNzQ=;
 b=e5YpwPeHK7pAtQ/qb0k69OTcEWf/KbpXCCJPLXQkuM8RXGXpBhD/XPcWItkbKTshWp5HIMPueTjwLWHAXHn4t9PsGA361buN5J/XU1M89pp9C/PNyWjkcNsKAMkkyZGxuuGzBHmaWDRIw9Bj2+WXSKzelCztognoPierPFf1d6w=
Received: from DB9PR02CA0005.eurprd02.prod.outlook.com (2603:10a6:10:1d9::10)
 by VI0PR08MB11552.eurprd08.prod.outlook.com (2603:10a6:800:2fd::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.9; Wed, 30 Sep
 2026 17:46:51 +0000
Received: from DB1PEPF000509EC.eurprd03.prod.outlook.com
 (2603:10a6:10:1d9:cafe::2c) by DB9PR02CA0005.outlook.office365.com
 (2603:10a6:10:1d9::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.15 via Frontend Transport; Wed,
 30 Sep 2026 17:46:51 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 4.158.2.129) smtp.mailfrom=arm.com;
 dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DB1PEPF000509EC.mail.protection.outlook.com (10.167.242.70) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.14
 via Frontend Transport; Wed, 30 Sep 2026 17:46:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kfkl2k50yIYjdGeMbUiIF0rrLLmt5/RkXdUnQVABHxYJT7Eh5OTIl9ZObXkohhFG/096DXxPKea0hK+UdBVNlB+rbDP7uCbeg8t2jb/PojZQarJ1Pq7hFRj0NDZ/5dm1E/3ESQk9QjWSDqa9mIaODPbhxpXkrbMBZ0+WsboP9vwclEhC1h2qhT4yqozVlGZgxkbrd54IDCGcrwprbr42T7K9hqSI3+VoDRa6hY9eBZf2laSJhfFIzeUiEs48q9IcvMZL21RmgNbsMoEa3eXqYx0EqNIMxVO/US3fFjvorKO4EOKTZ1R3TnjECWby5jX2YlQw3vwCGKR0YzXImFfEBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9aEn4ubSlfZC8d5zvTQtfBiiaBLSDPSceR3sArTbNzQ=;
 b=ZsggRuyxLjcd8+2f4JXPpiWJb7z/RdwMlc/1OsaKp3QfGH+7efVgUS7TRQ08hawPnxT9HZf0Io06NQwMx7j+vsSWq5URWBJVw9sLsLR2GraphdNuJscW6zflIaCHH/VRlwWOAb1g57Q3XS51Vg4QO4Ae8jm2ddAN89NCXmxeHIIrXnrbqSmZpUAe8CqLiabrAa9ZMZduVNzTwW8sqCtOIDiRW3qj1eNCtci7hVWc9hoDkgcKRT8lpEKnTS4wtgDGyRHQpTnF3mH5aMVZT0kPlClhF0tYKmwGQyNzhYcm+Bgezg9a0RlXWmcc2WOVk9GbmrodsgUUfb4Bt15Ani7PBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9aEn4ubSlfZC8d5zvTQtfBiiaBLSDPSceR3sArTbNzQ=;
 b=e5YpwPeHK7pAtQ/qb0k69OTcEWf/KbpXCCJPLXQkuM8RXGXpBhD/XPcWItkbKTshWp5HIMPueTjwLWHAXHn4t9PsGA361buN5J/XU1M89pp9C/PNyWjkcNsKAMkkyZGxuuGzBHmaWDRIw9Bj2+WXSKzelCztognoPierPFf1d6w=
Authentication-Results-Original: mx.microsoft.com 1; dkim=none (message not
 signed) header.d=none;dmarc=none action=none header.from=arm.com;
Received: from VI1PR08MB3421.eurprd08.prod.outlook.com (2603:10a6:803:80::16)
 by GVXPR08MB11787.eurprd08.prod.outlook.com (2603:10a6:150:316::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.14; Wed, 30 Sep
 2026 17:46:10 +0000
Received: from VI1PR08MB3421.eurprd08.prod.outlook.com
 ([fe80::e079:6bd:fbe0:89b4]) by VI1PR08MB3421.eurprd08.prod.outlook.com
 ([fe80::e079:6bd:fbe0:89b4%3]) with mapi id 15.21.0472.012; Wed, 30 Sep 2026
 17:46:09 +0000
Message-ID: <872cb298-8187-41b9-9553-b0db8ce0557d@arm.com>
Date: Wed, 30 Sep 2026 18:46:04 +0100
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
Subject: Re: [PATCH v3 4/9] mm: convert PTE table entries in ptep_get()
To: Anshuman Khandual <anshuman.khandual@arm.com>
References: <20260922-pte0-v3-0-5670b8cb9059@arm.com>
 <20260922-pte0-v3-4-5670b8cb9059@arm.com>
 <dhokijjou3rh3poqnqqpyoyac7wrqeprl4vlhzqokvh4lgjyya@g5hwn7sve3uw>
From: Muhammad Usama Anjum <usama.anjum@arm.com>
Content-Language: en-US
In-Reply-To: <dhokijjou3rh3poqnqqpyoyac7wrqeprl4vlhzqokvh4lgjyya@g5hwn7sve3uw>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PA7P264CA0519.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:3db::14) To VI1PR08MB3421.eurprd08.prod.outlook.com
 (2603:10a6:803:80::16)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: VI1PR08MB3421:EE_|GVXPR08MB11787:EE_|DB1PEPF000509EC:EE_|VI0PR08MB11552:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b58256c-5d5b-415d-2718-08df1f1acf12
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|366016|7416014|376014|1800799024|23010399003|4143699003|11063799006|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info-Original: l9hI3Oabjw6gk2JG4lKodRzavQcorcEJkMoiVGYQoSx+pVgXjpBAlCH28YVA/H2bcu8jFMcs8yxnXb7xuyR2ZeeuN3A+u+X5jWuxffvkJQbZsvGB8tb2uBFZcMGLiivoy9dPd61bi2sHr35UxZvCyrTIrPQ76+Sh2sG/3DyjHP+QMizypilAoFcP8nV/cWA80tumvBfHgDXt8s0K5GgeCvYY30O1n0DPnxNUBEBPK+clJf86c/ecxBanrf0WDwK5w1+ohTRBoty/hYdwebuCRhj3cWPqashM4L0j6hDkKLqyQwS4J0YSQA/fplSLcEQGX1nPD6kXh+XgqZ6u1kmMaCT0thxOi//qNQRgYxJwV7Tww3rnybN+1/5+/OZFh3zTQRTc37nGRDbROuSbe44gV3OlKhLbhjydQHt9rXpzeKHFAxCsX4ymZEQn5KfvB9SPdu1nsJM5tQjBQIyHn+Ax5Lmxko0RWGD8vb4+F3SUxwt4u0CysC7ovuOkCU81v7Rv7a3BNzVKZn6M3zRo4+hWZaMuHrUz1Fk81k6aU40s+kApEGWtVaan+h7nng4xRstkSkwPCfXrCT6XRLfHKHjpddNUzRQL84YDM4N29vH/K1BYa1Hyqiiw1Z6rGf4ABzjRiNlIyrEPDqwbJOjoy3McCnuETTq+P+jtnn0aqiqe/oE=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:VI1PR08MB3421.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(1800799024)(23010399003)(4143699003)(11063799006)(56012099006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: eoqglAgi1nBFmowgDYlmh5NsECyYCBBi4iKTD9HbyKVulUPH7OOZZLsafvPdLMO0oGoyPr7qaWHY2xesx2OQgVrH8JjZWtRk+t2XFLls+miJxEpk/QNUHsdCTIVRZIEYchd2GxPo17AQbM8nOhpZGYr16kOEfKUAasNgX6hcSVq8VsP38DSl9e0Y2dXy4RuwwYxY7Q7tBFLpU23WrT+9OyoCvb2Zu+xtx9O6NODp48Vj6lwcxGV6VqlXLdLC+Am5PnyTIMZsyGsZpqGmVHqTEhQOsvasmM9HQmSiTCySlMCmtES5hRd3FveryCz/uei0/g82wRy4F+uBe1UTxz5Qiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR08MB11787
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB1PEPF000509EC.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 99ea4608-baf6-473c-408a-08df1f1ab5ff
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|36860700016|82310400026|14060799003|35042699022|7416014|376014|4143699003|11063799006|10067099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: CQRDLlbWaYxiSWsBWPPHazI2Pv/ae0NaWVaDt+sXmmhTrQuYsbwAoNl4YpArOFOUCVrbylm/YrV8RW8tG2fXm4338msT+b4lvgzTN1Oxk6fkUyBRalpP08Vvq3KNWzFh0fd4f9qHaUX2Cs7BgHrnafgNGrySE8Cog2OlGNOUFZj8T+/F8Q1C9WkK8aj17CMWAnUHvXGZzUyD+E09qmQTppcBgPQTL6uckcOQk/zD4lnG5JK5/kxbqNNPFfVB3/NutKzgRuUgurCVzxbZN0MikxFCK9FuzDihxqg3SyxEg5/SHVDEjChI4gE0WIFks7MI3omyKp0yoSkelFy19bNHt/bOMXoe/VnviC0TgpviP75Tg2pjqJ6C3weJ/jGeDW7BaQgz/Vn57aLr2rZ9vmvUXlKV49RvprqEL/WDR60UBSuStvIhs83+xIWmT//qWxTtYLc/Sz5ga7BtAvsN4jnnUOoj3YrLbs45Zkd/PT7npkCokrx5BLFDr7DOv4zlgeKvw3hixQ6AlsJTrRBwaQtczt94XurR/t4Blxbw2ksxFiVeb/z8UzIqEoTgjyy0rJt5h8ZDzPCir+WDz0ZZqwraXAHYl6uz+DPelNREUBRzJx8/gA52KGmlMovTAxReGsWq+gG13qAvYLPZck21t2EVLw5ct0crJ50ewLJfozjtOYDLcHMtie2qmjC6xqH/AXYc4UDskJgn8Xst5mjZR1D/eA==
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(36860700016)(82310400026)(14060799003)(35042699022)(7416014)(376014)(4143699003)(11063799006)(10067099003)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: KdIfxWzrJ0uQ5ezYzhTTA7ec/24UvpcOpkp4niD6aSq3i4sXLkkFlKUmePrf2wX+laCD4X7spotQ4hqFUpmVBftk8X/aevo7edexB0NTxx6FCLSw1sQvzyVONGEtI+OuXci+OQqGf0o/zQCNEJvbbiW0hAGtrVLliJE67Zva2/8P0vyz6h2s81FH7MIdPXS0V4gCpjWOwasg82DFLzodhEgz8uzVZEsPpxgRzpEYQ7PbKAEcoKxFl3a4EqcUn5ZE58ivMFVkKxLAGuqgwH4oxvQ0GhNIULyu3GEdtYNnl5NgDYC7WaC1slXRNjdhQhnrO8sEDTvR0a7z9RW3PADI/eELj+PWqPfgEcSCBOu5qremODnZsNT2LpoCR40vrG/hplltCh0npK5UU7UxJshSBWxj+G7p3QY9rqCDcoTARXiyQVaMtoPDhf9x9OnptJ5F
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 17:46:51.2843 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b58256c-5d5b-415d-2718-08df1f1acf12
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: DB1PEPF000509EC.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR08MB11552
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

On 30/09/2026 6:10 am, Anshuman Khandual wrote:
> On Tue, Sep 22, 2026 at 06:12:32PM +0100, Muhammad Usama Anjum wrote:
>> ptep_get() now accepts a pointer to hw_pte_t storage but must continue to
>> return a software PTE value. Add __pte_from_hw for both generic hw_pte_t
>> definitions. Read the hw_pte_t table element atomically before converting
>> it to pte_t.
>>
>> Signed-off-by: Muhammad Usama Anjum <usama.anjum@arm.com>
>> ---
>> Changes since v1:
>> - Use software PTE value terminology.
>>
>> Changes since RFC v1:
>> - Define __pte_from_hw for the opted-in generic wrapper.
>> - Apply READ_ONCE() to hw_pte_t before converting it to pte_t.
>> ---
>>  include/linux/pgtable.h       | 2 +-
>>  include/linux/pgtable_types.h | 2 ++
>>  2 files changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
>> index 19098e302b75a..41337da0d65aa 100644
>> --- a/include/linux/pgtable.h
>> +++ b/include/linux/pgtable.h
>> @@ -493,7 +493,7 @@ static inline int pudp_set_access_flags(struct vm_area_struct *vma,
>>  #ifndef ptep_get
>>  static inline pte_t ptep_get(hw_pte_t *ptep)
>>  {
>> -	return READ_ONCE(*ptep);
>> +	return __pte_from_hw(READ_ONCE(*ptep));
>>  }
> 
> Just curious - when would other pgtable levels (PMD, PUD, P4D and PGD) be converted
> in this format as well ?

I've patches for conversion of all levels offline. But it would have been
so much difficult and complex (to review and rebase) if I would have posted
all of them. That's why this split was done. I'll be sending other conversion
after acceptance of these current series. PMD conversions has some patches
which require discussion. Other remaining levels are going to be straight
forward. Maybe I'll send those together.

-- 
Thanks,
Usama
