Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD91EC982D7
	for <dri-devel@archiver.kernel.org>; Fri, 18 Sep 2026 19:45:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F315D10E99D;
	Fri, 18 Sep 2026 19:45:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="bghfmRgJ";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B3C5210E99D;
 Fri, 18 Sep 2026 19:45:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789760724; x=1821296724;
 h=date:from:to:cc:subject:message-id:
 content-transfer-encoding:mime-version;
 bh=hE5YH7TbqrvgLQTv5OdzqswHVsFeZp2ht9HHBZGCeKs=;
 b=bghfmRgJS2xn2pHjYLqc29LsZmSwMN7kHLjGv4jV4Gx8mEkHYvls2SwY
 EQXgSRp5XtdgDvJlMKNFleJV/JffIYj8OwLJoHfz9P6e5rIJSLcM9WoL4
 N4VQRujQEO3nYdtl+NYHMbLxV6ST93QjX7C23Sy6b7xqchH4mulsI3Ypr
 C1ZKnNClgz5gX7p4oMmlQWZuLtoqEfwiinB1VqlC/Syv4DXhzLiOaObIx
 9cs5EHuc7+DUhx6/dq9s3x92QkrR3fb9A2vK4oPJI7arCe/7FxP3E3rDK
 jHIQTaCtbOZcwy4TtuL6FRY+Eyd0cQC0p5jGE5SQ6EpLAeQVGUBU/3XMf Q==;
X-CSE-ConnectionGUID: EunMDbGuS7uAFlcrFFhtVw==
X-CSE-MsgGUID: ayHMnk4NQM2jERtnvHj3Ug==
X-IronPort-AV: E=McAfee;i="6800,10657,11909"; a="100889616"
X-IronPort-AV: E=Sophos;i="6.27,109,1787036400"; d="scan'208";a="100889616"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Sep 2026 12:45:23 -0700
X-CSE-ConnectionGUID: OtP3uYWWT5ifvCONSU/7Sw==
X-CSE-MsgGUID: Jqd/dXq7SUeqs1bamB1Tyw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,109,1787036400"; d="scan'208";a="271896257"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Sep 2026 12:45:23 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 18 Sep 2026 12:45:22 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Fri, 18 Sep 2026 12:45:22 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.8) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 18 Sep 2026 12:45:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X/xa6U8pOIsg+r5TvvO8ASLYsulhtYiDGIJLamqmLQMqzbS6ZfaUzFZrsJDf/A71pogZfBUmU01qataCLweMG9SLnxEne/L2s6D9i3xilJ6wUMPXwZ2QBUyxXQ1t/Y7RTH5Jcbpmk6QedClwxevyssCz9X0Zg4zZY79JRBzN1GM1B3NT6VHLex2v+jDPEeOi/E6Dkc3qYVnYHcS9cNi2TUbXI4uHhPiL4k5TkW9QnaAOOj1C7ucFJST7MYoYeNh8N2qTLgUXpR7hWrHXWns1izZVjq0s3CbLEgjT4anoQUa7gqH8JqcQe7LQneUM8boJf3IWiJjeQip/tChmZuX95A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EHZyrVhDuGphtoMwvzv+XyW2gPXFmBmiVIa6q7NAWLE=;
 b=tz+6daFMmIt2v4DwOfZe9TskJ3Lq4fGT03dz2WfVxduQJAntvSxOUwxJCG00Ypp2f3rcxx5nx6UJdaB1edmUrQ+U3TP3aMHu7V20zmvR+aPAKos1TC3HLAxbirm8DrrxGIcKXNgeAy9tIh4m76sWT4mkyVXdHuzD2dpgx+JQyyb8W9TvDQy6nhJBvHxt2aY3oH4N2P3g7ChziFHfdeI5C0fXdN8md2r0PevRAtNKJQdmRQbLUepH/mk6oDnwieDwo+Ddx3xMEiW9cpv3s7v+hyqgpVCJvRVq/yDtTUxkpr2114JdceCmiubXJw8SN6Etmyaj/3YqUdMteRl+zBauSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4787.namprd11.prod.outlook.com (2603:10b6:303:95::23)
 by DS6PR11MB647574.namprd11.prod.outlook.com (2603:10b6:8:410::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.13; Fri, 18 Sep
 2026 19:45:20 +0000
Received: from CO1PR11MB4787.namprd11.prod.outlook.com
 ([fe80::e7eb:a872:53d1:21fd]) by CO1PR11MB4787.namprd11.prod.outlook.com
 ([fe80::e7eb:a872:53d1:21fd%4]) with mapi id 15.21.0428.011; Fri, 18 Sep 2026
 19:45:20 +0000
Date: Fri, 18 Sep 2026 12:45:17 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: Dave Airlie <airlied@gmail.com>, Simona Vetter <simona.vetter@ffwll.ch>
CC: Jani Nikula <jani.nikula@linux.intel.com>, Joonas Lahtinen
 <joonas.lahtinen@linux.intel.com>, Tvrtko Ursulin <tursulin@ursulin.net>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, Thomas Zimmermann
 <tzimmermann@suse.de>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Matthew Brost <matthew.brost@intel.com>,
 Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>, "Oded
 Gabbay" <ogabbay@kernel.org>, <dri-devel@lists.freedesktop.org>,
 <intel-gfx@lists.freedesktop.org>, <intel-xe@lists.freedesktop.org>,
 <dim-tools@lists.freedesktop.org>
Subject: [PULL] drm-xe-next
Message-ID: <aq2UzTdN95ZpzKGz@gsse-cloud1.jf.intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY3PR03CA0003.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::8) To CO1PR11MB4787.namprd11.prod.outlook.com
 (2603:10b6:303:95::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4787:EE_|DS6PR11MB647574:EE_
X-MS-Office365-Filtering-Correlation-Id: cd18fc30-73e2-4707-5686-08df15bd5f62
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|7416014|376014|366016|10067099003|6133799003|3023799007|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: RESIyD7F22j1ELh70ZrSZMrj2H0zehkflnklAgn2ffDO6OozgZwQUwhCKmXi+VuV5BG8H5fRfHjueSKOKTWWth0XPZiK5MCxEzLVilu1N39eqKg21dhm4H9y1gZ926eDa0gnq4Lm97mBquXdpHCmf2WOAHpJ9TQAGK63sJENXUtjpAXBMyp22OF+uhok5EIW8CNseFl7CEhtDYsM5EEs2k5gGOH8iBlmuMxLUfAdXUmHttc0hu/63Qg5cIKBIOeXqWVVjBUaSVBG80hKHKAsb1OPhwRZimCbDGvIPekTq5fMuh4Iebsl2zoqTWvb+tsbhMmlR/TACnBQvrtbN4oOXrUqHejUuOOmyqfFeTqe0dtubMeC7H9tLYgDUR4zVUSvqtyrf/Y9K7tZ/ln/frz5AmEfThAAMVEO6N4/MpLWEm8W/Pm3nmAiApiwsp9V3reDDplgnCC7gyRPpf9zgMtJNHvjMP9xrJ7mEhK2H+1vA5V+88FgnCAiFFaPVy+8K0M6vA4Es/9gJ2KoWUrgJRl69wLwlCEjlCR7bV6WM3n3+o6xbBuBClX5fG7FKIk9RS/N1LzMal8KH9vZpPm4aMvhMrYjL30PeZ8VruWror5ymif/Y8Jl78JZe87kIDjIEFDn
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO1PR11MB4787.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(7416014)(376014)(366016)(10067099003)(6133799003)(3023799007)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?UfkKTQk8y+rIl9vL3MEHmI+v0aOZ1aU88oTw8RzKSfhbETqrTr2zn9cL82?=
 =?iso-8859-1?Q?KHQXGm91BrtMFuM3a04UhJb45imRY8MO3OxZhPc9sQK1gvFJYgTMGktIJz?=
 =?iso-8859-1?Q?i2bMlycbhzRG1ZZ1n/CL0s9Aj4kNrXoxLz2zqYDdlVg8fxRzfTqpQjDukY?=
 =?iso-8859-1?Q?oOjIIQP7VgQJpPj1BDrPC97DU60Kfq3+URe9YA/8xA1yl7qy08hC9xI0I4?=
 =?iso-8859-1?Q?6K5p6VWocKTWATWXN7NGQ4TCV4FECs4yq7THZFr6rTts0PtspdUOAB1a5K?=
 =?iso-8859-1?Q?v6xzJIk28duoLsi+DapFnLqIymWk7sQDEGcHxhuOrwN1QBz3LcgSUjOpQD?=
 =?iso-8859-1?Q?+WAAMGW3XWIz0aLLdoYUti4NSwBeN5uC6qpC+oiHKdzDl9wTD8MJRxfUG1?=
 =?iso-8859-1?Q?doJqx7jX9k1RRwqgcuu6UuQ8A5Si6Das2HzwUer3Z1XOkpYGpDVX+KkEwW?=
 =?iso-8859-1?Q?0QtIX2cnZKvxF4DBJfUeaQHF0BoTLRzFAnOzgZC0PoeGFQdKOUoHtC2ecA?=
 =?iso-8859-1?Q?v9tBixUv/ZCCPt9O/y0FQH1cJ+MhqagRV356c+2QkYtncLf1pfn9guo2vg?=
 =?iso-8859-1?Q?1XZQr0gHWgaS7JOgl9cVohLvc579x1JfHi5a4mmvnsP+jW9TaEc/1fevma?=
 =?iso-8859-1?Q?/o26f+727TZIET1i6IstN/xRWmLRqcZmgkVxXaZWtiPRHoq2KVvwEA8GNM?=
 =?iso-8859-1?Q?r4/rl+Jhfe33eQB4fX4ojah2KJEyLfV+1YdNMek0kxSS+GUDeOdXMXsvtw?=
 =?iso-8859-1?Q?O/Fg8eO+PQh3RkaE/Z2vVe5NAwbPwkQbIC1pLKYqTPYrJmhkHkWCOr6L07?=
 =?iso-8859-1?Q?Y5u8vdaQVRMZamqciRzitRNjyOO6rqkdmJHshajAb1RAmZ2IPdIDvJOWzx?=
 =?iso-8859-1?Q?4cAdm9PqS3c8wR8BBLYEGYs8EzS/sQAUBZ4SAL8ZPo8vz+XaGOOpxGsa+r?=
 =?iso-8859-1?Q?FOpJXrDJ9a6RfWdzZF6D47vdhtH0FhQuO9KU3yn7HuTx07w2dHH1qUxgdU?=
 =?iso-8859-1?Q?3Ns/2IeKszSZ6+1wYSkDm0va9DJV+EMZc0Wr0ZloEIESf2bBsd3G2yQcXw?=
 =?iso-8859-1?Q?rvt1/pq5SjywNUObHCwnfRPcea/xXSiyXjc0qki1IuWPiUlszDWIeUQIkT?=
 =?iso-8859-1?Q?W5hSY4orrLeTsTLu0uPwpOZOuGUt0/HiAieGnQHHVZEykK68CN1bxBLkaA?=
 =?iso-8859-1?Q?NLVLrmQaozNhhDpaj9XiVEWTH579YtQ35aepq6hzkT/mwcLYTO8YlUPBvY?=
 =?iso-8859-1?Q?yO32RI80qbD0B7psqIldz2cK3Kh6TY54ciSmdFG7QWbv7FWmdgp75EQnoy?=
 =?iso-8859-1?Q?VMpATN5ZqlK9BdyRMCKEffhZcjxZPw1wCu0k346Pb86H9Y/jKoUEJSIczQ?=
 =?iso-8859-1?Q?AoaAx46HRRc9TO1EWef6BvXhn3ERcwp3CMfG4yIj63eK8zFD4XkP9J0B0N?=
 =?iso-8859-1?Q?M8Wj4vK1tpdyxkuY1/oActWYxje1Z6AOLWMpnz9Xv1Mc3gHe3HfhpANhgF?=
 =?iso-8859-1?Q?jYse4Y868aWFI3Pj4WL3wO0CkKlQ4MA5x+x4RvGY9hzzFwBDFzlf+FItpD?=
 =?iso-8859-1?Q?Z6BY3pKgzxBOoAqI6GA0ngzYCQLJzOLA+Zx5mE6K0Lr3ChWM12mf0tLbrx?=
 =?iso-8859-1?Q?oR3IXdobIJnFIT4+emYTSzf4G0xpSQJACmhuW9jOJZdHseYsTeIrti2J+X?=
 =?iso-8859-1?Q?ZpAS6Gd0JAJeL+Lbd+joY9DLmro+Z+jAfTAg0GTBrLtSWqc4/+bIVwcXkO?=
 =?iso-8859-1?Q?liEvzPXP6YjwtdTxLOUwKbHQ2Bj6lmg9JOU6xxntc8X0biBkBpYP8nsVnh?=
 =?iso-8859-1?Q?++VRT1Dkip9s5q6nF8oGnheB3bILJbs=3D?=
X-Exchange-RoutingPolicyChecked: VchcVUe1RM3diHvyoGQWcuhwNQv6I/ndOALOYc1jC9rWtF9Vrnrqd8c9O1xOZhUuJ18dfAYx0dRJ2UPEshy6pCBMib5/7N5GjC4QNykejX2vKPBSeYJU8Lca4mnjI0IlWX6XJTstrknL+tHGi2glkeIjcgGqB3c+OXk9EwwlXD1YLUyNzZ351Jzck9UgypUD0z005BgJgoME59DWO9r8F4HU4g87PgHim0sSaI9jprS+J1i1oTvjslUkuf/Wa3TCAgSReMu0fBzhocFZb/DeuzPcMWfybq4xJ2xUWSEUme5C1GKNze2muS2mS9C46llEp//3CAT7HerJMUZ5Nj/+Mw==
X-MS-Exchange-CrossTenant-Network-Message-Id: cd18fc30-73e2-4707-5686-08df15bd5f62
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4787.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2026 19:45:20.4486 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ml4ZPwUpVf2ol8GH4SgThhyepJPjygByqihPxZvTIfokYAIU1SGzp1LywboFs+1Er+LvyDZ+dbt7k+BDjUQ7iQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS6PR11MB647574
X-OriginatorOrg: intel.com
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

Hi Dave and Sima,

Here goes our second drm-xe-next pull towards 7.4.

Big things we have are: VRAM health check + CCS fix (test for a bug
Linus root caused), GPUSVM supporting multiple dma-mappings for a
get_pages() call + inline mappings, memory page offlining, and continued
SIGID logging work.

Matt


drm-xe-next-2026-09-18:
UAPI Changes:
- Add SRCID to pagefault reporting (Jonathan)

Cross-subsystem Changes:
- gpusvm: share one HMM fault and keep single mappings inline (Honglei)
- pagemap: Prevent CPU stalls during unbounded pagemap teardown (Varun)

Driver Changes:
- VRAM health check + CCS fix (Auld)
- Add memory page offlining support (Tejas)
- Report GT TDR and VM rebind faults using SIGID (Arvind)
- Flush LSC untyped L1 dataport cache after rcs/ccs batches (Thomas)
- Add multi_queue_active_lrca debugfs (Varun)
- mmio_gem: fix fault handler and destroy path (Auld, Ilia, Shuicheng)
- sysctrl: Add helper to query application status (Anoop)
- shrinker: Runtime PM reference for non-system memory (Shuicheng)
- pcode: Increase default mailbox timeout (Karthik)
- Skip clearing purged page-table BOs (Tejas)
- tests: Fix subplatform selection (Wajdeczko)
- log: Relax location ID recognition (Wajdeczko)
- i2c: Disable IRQ on unbind (Raag)
- Refactor VF LMEM BAR resize helper function (Wajdeczko)
- pf: Add _locked variant of config functions (Wajdeczko)
- nvm: add system controller region (Alexander)
- guc: Add simple KLV decoder helpers (Wajdeczko)
- debugfs: Expose per-engine idle status (Anirban)
- gt_throttle: Report power brake as a throttle reason on CRI (Anirban)
- tlb_inval: Treat wedged-device invalidations as complete (Shuicheng)
- Add mnemonic error reason to page fault diagnostics (Brost)
- Keep walking on SVM eviction failure (Brost)
- Make p2pdma distance check verbose via dynamic debug (Thomas)
- Consolidate semaphore instruction definitions (Roper)
- Poll GT for C6 before D3 (Vinay)
The following changes since commit cc467969646b9778c947bec1383fb3cdaada14d5:

  Merge drm/drm-next into drm-xe-next (2026-08-31 15:42:28 -0700)

are available in the Git repository at:

  https://gitlab.freedesktop.org/drm/xe/kernel.git tags/drm-xe-next-2026-09-18

for you to fetch changes up to 320662381ca243a3364663e917a7447afaf618fa:

  drm/xe: Poll GT for C6 before D3 (2026-09-18 11:52:56 -0400)

----------------------------------------------------------------
UAPI Changes:
- Add SRCID to pagefault reporting (Jonathan)

Cross-subsystem Changes:
- gpusvm: share one HMM fault and keep single mappings inline (Honglei)
- pagemap: Prevent CPU stalls during unbounded pagemap teardown (Varun)

Driver Changes:
- VRAM health check + CCS fix (Auld)
- Add memory page offlining support (Tejas)
- Report GT TDR and VM rebind faults using SIGID (Arvind)
- Flush LSC untyped L1 dataport cache after rcs/ccs batches (Thomas)
- Add multi_queue_active_lrca debugfs (Varun)
- mmio_gem: fix fault handler and destroy path (Auld, Ilia, Shuicheng)
- sysctrl: Add helper to query application status (Anoop)
- shrinker: Runtime PM reference for non-system memory (Shuicheng)
- pcode: Increase default mailbox timeout (Karthik)
- Skip clearing purged page-table BOs (Tejas)
- tests: Fix subplatform selection (Wajdeczko)
- log: Relax location ID recognition (Wajdeczko)
- i2c: Disable IRQ on unbind (Raag)
- Refactor VF LMEM BAR resize helper function (Wajdeczko)
- pf: Add _locked variant of config functions (Wajdeczko)
- nvm: add system controller region (Alexander)
- guc: Add simple KLV decoder helpers (Wajdeczko)
- debugfs: Expose per-engine idle status (Anirban)
- gt_throttle: Report power brake as a throttle reason on CRI (Anirban)
- tlb_inval: Treat wedged-device invalidations as complete (Shuicheng)
- Add mnemonic error reason to page fault diagnostics (Brost)
- Keep walking on SVM eviction failure (Brost)
- Make p2pdma distance check verbose via dynamic debug (Thomas)
- Consolidate semaphore instruction definitions (Roper)
- Poll GT for C6 before D3 (Vinay)

----------------------------------------------------------------
Alexander Usyskin (1):
      drm/xe/nvm: add system controller region

Anoop Vijay (2):
      drm/xe/sysctrl: Add helper to query application status
      drm/xe/sysctrl: Add helper to check oCode firmware readiness

Arvind Yadav (4):
      drm/xe/log: Add GUCSUBMIT component
      drm/xe/guc: Report reset failure using SIGID
      drm/xe/svm: Report terminal page-fault failures using SIGID
      drm/xe/gt: Report GT reset failure using SIGID

Honglei Huang (6):
      drm/gpusvm: move dma_addr allocation before the notifier lock
      drm/gpusvm: extract drm_gpusvm_dma_map_pages() helper
      drm/gpusvm: let drm_gpusvm_get_pages() map an array of pages
      drm/gpusvm: make the DMA mapping step in get_pages() optional
      drm/gpusvm: keep a single DMA mapping inline for THP
      drm/gpusvm: keep an IOVA mapped range dma address inline

Ilia Levi (5):
      drm/xe/mmio_gem: forbid VMA split
      drm/xe/mmio_gem: use write-back mapping for dummy page
      drm/xe/mmio_gem: simplify fault handler loop
      drm/xe/mmio_gem: cache the dummy page per object
      drm/xe/mmio_gem: fix destroy flow

Jonathan Cavitt (2):
      drm/xe/pagefault: Add SRCID to pagefault struct
      drm/xe/vm: Add srcid to xe_vm_get_property_ioctl fault report

Karthik Poosa (2):
      drm/xe/pcode: Increase default pcode mailbox timeout to 10ms
      drm/xe/hwmon: Use shared pcode default timeout for power limit write

Matt Roper (1):
      drm/xe: Consolidate semaphore instruction definitions

Matthew Auld (7):
      drm/xe/migrate: support 4K PTEs for identity map
      drm/xe/vram: report FLAT_CCS base misalignment
      drm/xe/vram: revamp CPU VRAM mapping
      drm/xe: add force option for global invalidation
      drm/xe/vram: add early VRAM health check
      drm/xe/mmio_gem: reject VM_EXEC and drop VM_DONTCOPY
      drm/xe: convert PCI barrier mmap to use xe_mmio_gem

Matthew Brost (2):
      drm/xe: Add mnemonic error reason to page fault diagnostics
      drm/xe: Keep walking on SVM eviction failure

Michal Wajdeczko (15):
      drm/xe/tests: Fix default subplatform selection
      drm/xe/tests: Fix subplatform selection
      drm/xe: Drop unused parameter from xe_info_init
      drm/xe: Keep reference to device descriptor
      drm/xe: Drop redundant parameters from xe_info_init_early
      drm/xe: Drop redundant parameter from xe_probe_info_early
      drm/xe: Drop redundant parameter from xe_probe_info and friends
      drm/xe/log: Relax location ID recognition
      drm/xe/pf: Refactor VF LMEM BAR resize helper function
      drm/xe/pf: Add _locked variant of the priority config function
      drm/xe/pf: Add _locked variant of the release config function
      drm/xe/pf: Add _locked variant of the fair sched config function
      drm/xe/guc: Add simple KLV decoder helpers
      drm/xe/tests: Add kunit tests for KLV decoders
      drm/xe/pf: Use KLV decode helpers to parse migration packet

Raag Jadav (1):
      drm/xe/i2c: Disable IRQ on unbind

Shuicheng Lin (4):
      drm/xe/mmio_gem: Revoke drm_vma_node on xe_mmio_gem destroy
      drm/xe/shrinker: Return the freed page count through a parameter
      drm/xe/shrinker: Take a runtime PM ref before shrinking non-system memory
      drm/xe/tlb_inval: Treat wedged-device invalidations as complete

Sk Anirban (2):
      drm/xe/debugfs: Expose per-engine idle status
      drm/xe/gt_throttle: Report power brake as a throttle reason on CRI

Tejas Upadhyay (16):
      drm/xe: Link VRAM resource allocation with gpu buddy
      drm/xe: Link LRC BO and its execution queue with safe lifetime rules
      drm/xe: Export xe_ttm_bo_purge()
      drm/xe: Handle NULL resource and allow purging of VRAM pages
      drm/xe/bo: Make xe_bo_is_user() public
      drm/xe: Guard teardown paths against purged BOs
      drm/xe/vram: Extract buddy allocation and free helpers
      drm/xe/vram: Add page offline data structures and lifecycle
      drm/xe/vram: Add VRAM page offline fault handler
      drm/xe/configfs: Add disable_vram_page_offline attribute
      drm/xe/ras: Cache disable_vram_page_offline policy at init
      drm/xe/vram: Check disable_vram_page_offline policy in fault handler
      drm/xe: Expose bad VRAM pages via debugfs
      drm/xe/uapi: Expose ban reason in EXEC_QUEUE_GET_PROPERTY_BAN
      drm/xe: Add fault-inject based VRAM page offline injection
      drm/xe: Skip clearing purged page-table BOs

Thomas Hellström (2):
      drm/xe: Flush LSC untyped L1 dataport cache after rcs/ccs batches
      drm/xe: Make p2pdma distance check verbose via dynamic debug

Varun Gupta (3):
      drm/xe: Guard page-fault worker with runtime PM check
      drm/xe: Add multi_queue_active_lrca debugfs
      drm/pagemap: Prevent CPU stalls during unbounded pagemap teardown

Vinay Belgaumkar (1):
      drm/xe: Poll GT for C6 before D3

 drivers/gpu/drm/drm_gpusvm.c                       | 410 ++++++++++----
 drivers/gpu/drm/drm_pagemap.c                      |   5 +-
 drivers/gpu/drm/xe/abi/xe_log_abi.h                |   1 +
 drivers/gpu/drm/xe/display/xe_dsb_buffer.c         |   2 +-
 drivers/gpu/drm/xe/display/xe_fb_pin.c             |   2 +-
 drivers/gpu/drm/xe/display/xe_panic.c              |   3 +-
 drivers/gpu/drm/xe/instructions/xe_gpu_commands.h  |   1 +
 drivers/gpu/drm/xe/instructions/xe_mi_commands.h   |   7 +-
 drivers/gpu/drm/xe/regs/xe_gt_regs.h               |  28 +
 .../gpu/drm/xe/tests/xe_guc_klv_helpers_kunit.c    | 303 +++++++++++
 drivers/gpu/drm/xe/tests/xe_pci.c                  |  25 +-
 drivers/gpu/drm/xe/xe_bo.c                         |  83 ++-
 drivers/gpu/drm/xe/xe_bo.h                         |   3 +-
 drivers/gpu/drm/xe/xe_bo_types.h                   |   8 +
 drivers/gpu/drm/xe/xe_configfs.c                   |  72 ++-
 drivers/gpu/drm/xe/xe_configfs.h                   |   2 +
 drivers/gpu/drm/xe/xe_debugfs.c                    |  51 ++
 drivers/gpu/drm/xe/xe_debugfs.h                    |   2 +
 drivers/gpu/drm/xe/xe_devcoredump.c                |   4 +-
 drivers/gpu/drm/xe/xe_device.c                     | 120 +----
 drivers/gpu/drm/xe/xe_device.h                     |   2 +-
 drivers/gpu/drm/xe/xe_device_types.h               |  19 +
 drivers/gpu/drm/xe/xe_dma_buf.c                    |  22 +-
 drivers/gpu/drm/xe/xe_drm_ras_types.h              |   3 +
 drivers/gpu/drm/xe/xe_exec_queue.c                 |  72 ++-
 drivers/gpu/drm/xe/xe_exec_queue_types.h           |   7 +-
 drivers/gpu/drm/xe/xe_execlist.c                   |   4 +-
 drivers/gpu/drm/xe/xe_gt.c                         |  11 +-
 drivers/gpu/drm/xe/xe_gt_debugfs.c                 | 106 +++-
 drivers/gpu/drm/xe/xe_gt_idle.c                    |  39 ++
 drivers/gpu/drm/xe/xe_gt_idle.h                    |   1 +
 drivers/gpu/drm/xe/xe_gt_sriov_pf_config.c         | 108 +++-
 drivers/gpu/drm/xe/xe_gt_sriov_pf_config.h         |   4 +
 drivers/gpu/drm/xe/xe_gt_throttle.c                |   5 +-
 drivers/gpu/drm/xe/xe_guc_capture.c                |   2 -
 drivers/gpu/drm/xe/xe_guc_klv_helpers.c            |  78 +++
 drivers/gpu/drm/xe/xe_guc_klv_helpers.h            |   5 +
 drivers/gpu/drm/xe/xe_guc_pagefault.c              |   8 +-
 drivers/gpu/drm/xe/xe_guc_submit.c                 | 115 +++-
 drivers/gpu/drm/xe/xe_guc_submit.h                 |   5 +
 drivers/gpu/drm/xe/xe_hwmon.c                      |   7 +-
 drivers/gpu/drm/xe/xe_i2c.c                        |   3 +
 drivers/gpu/drm/xe/xe_log.c                        |  42 +-
 drivers/gpu/drm/xe/xe_lrc.c                        |   6 +-
 drivers/gpu/drm/xe/xe_lrc.h                        |   1 +
 drivers/gpu/drm/xe/xe_migrate.c                    | 121 ++++-
 drivers/gpu/drm/xe/xe_migrate.h                    |   6 +
 drivers/gpu/drm/xe/xe_mmio_gem.c                   | 115 ++--
 drivers/gpu/drm/xe/xe_mmio_gem.h                   |   2 +-
 drivers/gpu/drm/xe/xe_nvm.c                        |   1 +
 drivers/gpu/drm/xe/xe_pagefault.c                  | 128 ++++-
 drivers/gpu/drm/xe/xe_pagefault.h                  |  67 ++-
 drivers/gpu/drm/xe/xe_pagefault_types.h            |  91 +++-
 drivers/gpu/drm/xe/xe_pci.c                        |  42 +-
 drivers/gpu/drm/xe/xe_pci_sriov.c                  |  27 +-
 drivers/gpu/drm/xe/xe_pcode.c                      |   2 +-
 drivers/gpu/drm/xe/xe_pcode.h                      |   4 +-
 drivers/gpu/drm/xe/xe_pm.c                         |  18 +
 drivers/gpu/drm/xe/xe_pm.h                         |   1 +
 drivers/gpu/drm/xe/xe_pt.c                         |  28 +-
 drivers/gpu/drm/xe/xe_ras.c                        |   9 +
 drivers/gpu/drm/xe/xe_res_cursor.h                 |   5 +-
 drivers/gpu/drm/xe/xe_ring_ops.c                   |  15 +-
 drivers/gpu/drm/xe/xe_shrinker.c                   | 124 +++--
 drivers/gpu/drm/xe/xe_sriov_packet.c               |  31 +-
 drivers/gpu/drm/xe/xe_svm.c                        |  36 +-
 drivers/gpu/drm/xe/xe_svm.h                        |  20 +
 drivers/gpu/drm/xe/xe_sysctrl.c                    |  92 ++++
 drivers/gpu/drm/xe/xe_sysctrl.h                    |   2 +
 drivers/gpu/drm/xe/xe_sysctrl_mailbox_types.h      |  45 ++
 drivers/gpu/drm/xe/xe_tile_types.h                 |   4 +
 drivers/gpu/drm/xe/xe_tlb_inval.c                  |   3 +-
 drivers/gpu/drm/xe/xe_ttm_vram_mgr.c               | 600 ++++++++++++++++++++-
 drivers/gpu/drm/xe/xe_ttm_vram_mgr.h               |   3 +
 drivers/gpu/drm/xe/xe_ttm_vram_mgr_types.h         |  40 ++
 drivers/gpu/drm/xe/xe_userptr.c                    |   2 +-
 drivers/gpu/drm/xe/xe_vm.c                         |  15 +-
 drivers/gpu/drm/xe/xe_vm_types.h                   |   2 +
 drivers/gpu/drm/xe/xe_vram.c                       | 258 ++++++++-
 drivers/gpu/drm/xe/xe_vram.h                       |  10 +
 include/drm/drm_gpusvm.h                           |  71 ++-
 include/uapi/drm/xe_drm.h                          |  22 +-
 82 files changed, 3301 insertions(+), 568 deletions(-)
