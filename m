Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAFB2606A323
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 21:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=lTHHh+BN;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=PLgeDOzL
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2D80210F061;
	Tue, 24 Nov 2026 21:07:03 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8314710E231;
 Tue, 24 Nov 2026 21:06:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795554412; x=1827090412;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:content-transfer-encoding:mime-version;
 bh=gkrmcCG4JJ8DgsR5UQ9S719eiyy7slTY0HfaLhcb0j0=;
 b=lTHHh+BNNt8cZtel681l0YNrPsOSKeV6zF4nma39pcdfJygNnLwULrky
 65dJ+FGoL7+VBx+ZUOBjuyAB8v0HIRCzpmWiVEkK+9+XS+cvUJEEOAReq
 ibGN45/4UY0S3mbtsqSsFozahkZCAw6m05+jmvMQI2eKzgZgAYqxLVgqV
 DTh0MW1RdEUm9ptQGpKWSDIKILLqb0JY7ZlcCmVtvlyeGdOqs1iTkRwdT
 3vKJ2MQEDTalSbqxkoFwj+nxmQw2NH1sfpWEV+ytgF24a7oLDzHmBPE/8
 3hHaBSab8EHZG0zimp1wxXSsvi8fPR00sttgz1DR3PwDVlF7lqYLhYAbP Q==;
X-CSE-ConnectionGUID: k5el0luqSiangALJsybkEQ==
X-CSE-MsgGUID: elT+kak7Sh6F5rb2IBaguQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11976"; a="4386340"
X-IronPort-AV: E=Sophos;i="6.27,231,1787036400"; 
   d="scan'208";a="4386340"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Nov 2026 13:06:48 -0800
X-CSE-ConnectionGUID: AmfMUFgyQ8CttKQ4eFkUlQ==
X-CSE-MsgGUID: 6eHSEvtfT6iKfEZx5nYJww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,231,1787036400"; d="scan'208";a="11568991"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Nov 2026 12:39:28 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Tue, 24 Nov 2026 12:39:27 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57 via Frontend Transport; Tue, 24 Nov 2026 12:39:27 -0800
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.28) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Tue, 24 Nov 2026 12:39:26 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fpY2+nWUpdT3PCG1wi3BI+2HMtvg0uUVjfQCkd2N5zqWFWi8v8vcwjPZXPN7GqsAF5vtgUvQBl+ljKSsZrHFuNtmgaX6JijK4FsxTaieqXpWK6G8A/gPfR5iXtUuXhWttgiLk8AGfKv1vcml4HPJajjwGv80AB1Ha9/kQzHD4vpLLW2FMwjZyK3p2qiMMJer2297wTwPpdBUqOkCqfyrvp9jTGXCJmteCsfx0uaW7ERT7f3027IZSZhPFaq3N8svDdcHhDyG3ehA3DzAOH1bsqgU7WeOjauAN6F3B1nJCyhD2AjiYpUoHNCzNNNNXPd6Aqper1jMttLqxgwyJuO7/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3vgx3D4e+5d+Y2OM8B6Ygu0EB2UmlE0DKju1k/yuz2s=;
 b=fG3cB7kuAfgrFJKtzQNP7rXY2DswO1GQkFFNRO6wExU45/brJzX9bgISamS/jzbZhfSypbfFIDRVEzrcr13fXiPSYyBoVmC+toG0uofNI2i2Fu2wmYh9HB852F+A37yrxVn6mGkShwN4dPtBiOZMrpmOITPEuxnuPE6hW5jbHv0CLnS/b8V0eIqJ2B4RgshRYBDlbxMOWKW+/vzE6ZdLKfINS67QTX81Bk+J5pg7VyYYlkSB+GmYAm3lQm5M8gwVUHktKx25xuG5svjNPF1Bs3nRjfNAa6VjemRk2FXdHzrsvwVIuXE+ZDoB4WxbEm8G1YvP1RBEi4GNI6Aok3WOKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3vgx3D4e+5d+Y2OM8B6Ygu0EB2UmlE0DKju1k/yuz2s=;
 b=PLgeDOzLrK4VI5ImkVpqfztydDyxE3DSymrFbNPS9DlvXs4RqiFAsht89OPXCAl2AGqkWoNVZL15vswyj1tYBbkmhbK86PjbNqiYUl0UPWIryINZNaPtC6tWvfU6xrzzt1TYr0irStxVypvuA6pO/zb+sy9HckY9Z6w9B9C56nc=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS7PR11MB5990.namprd11.prod.outlook.com (2603:10b6:8:71::5) by
 SJ1PR11MB6249.namprd11.prod.outlook.com (2603:10b6:a03:45a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.5; Tue, 24 Nov
 2026 20:38:44 +0000
Received: from DS7PR11MB5990.namprd11.prod.outlook.com
 ([fe80::133c:5eed:3aec:b899]) by DS7PR11MB5990.namprd11.prod.outlook.com
 ([fe80::133c:5eed:3aec:b899%3]) with mapi id 15.21.0639.011; Tue, 24 Nov 2026
 20:38:39 +0000
From: Rodrigo Vivi <rodrigo.vivi@intel.com>
To: <dri-devel@lists.freedesktop.org>
CC: <intel-xe@lists.freedesktop.org>, Aravind Iddamsetty
 <aravind.iddamsetty@linux.intel.com>, Jakub Kicinski <kuba@kernel.org>,
 "Riana Tauro" <riana.tauro@intel.com>, Raag Jadav <raag.jadav@intel.com>,
 "Zack McKevitt" <zachary.mckevitt@oss.qualcomm.com>, Jeff Hugo
 <jeff.hugo@oss.qualcomm.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>
Subject: [PATCH v4 1/2] drm/ras: Add retired-pages node type
Date: Tue, 24 Nov 2026 15:38:35 -0500
Message-ID: <20261124203833.3618507-5-rodrigo.vivi@intel.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261124203833.3618507-4-rodrigo.vivi@intel.com>
References: <20261124203833.3618507-4-rodrigo.vivi@intel.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0258.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::23) To DS7PR11MB5990.namprd11.prod.outlook.com
 (2603:10b6:8:71::5)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR11MB5990:EE_|SJ1PR11MB6249:EE_
X-MS-Office365-Filtering-Correlation-Id: f224fc51-30fa-4c72-368c-08df4a6aebf8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|366016|6133799003|261009223327099003|261009220027099003|261009221227099003|261009221727099003|261009223027099003|22082099003|18002099003|56012099006|11063799006|261028144727099003|261102123227099003|261026140227099003|261026121527099003|261022075727099003|261021123027099003|261021121427099003|261022105027099003|10067099003;
X-Microsoft-Antispam-Message-Info: rZblUHdPNWvDZhLQkDIyMtyMe5THx9ew8TWzqWR7F8B35vHjwb1NFeDtRW1pl/Y2RK/Qp+tSfOAmFZIVtNYNpl5u5AuP3b0xwPm/Yj9MwruN3sRaV/8CkCAXE5KniUITeXNUjTI0xQtoq6mj8Rg6vcqmIsdg0AO3scoO8amnKvXowdv+mmUhQAs4XH5pv0Qmbi5qF6LPYqo1tqHlRJk63V4sVzbooTxCV6qrtqiflMpV8bEJ9sEYwmIwc7hVgSnVlRrXubJjaabH0Lu0XV66mufxARtSPvsjNiFcRlJxQBWyfl9DZbDd+FGNZAXC6RzdxWsIrzs5M5J6bEEOMuAMh+1kO2rKSLx203gBm5ndjEg9nikgnNQF0SUW7qZ+SRWOS5m05XQXqb9beCqQsoBfVMPL0OPOw/xFXw3vfL7PLQlR1xgMglHQCjtdUtBPj4M5OZMh3CVlnXOzZLyBcvJ1zK+cNyFwj562qkqxySNXLpCbI8PkqqY/x+ZJVCm5hxDnQi8At52l9MKr1vYZE93Ehtav3Ck5teiQqu4Q/NNrJFXWpmA8mQAYM484cUtujGd0XMDW0Gt5iZojrUaXWTHFZFksUJSx2wvcoPko5wlXQThqTj7EBYPeXJ8g4Wa6orabVIpzvhhC5k9Tp5tCT2Q3M6hMxtMkXc0lm1aJc8KfbUQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR11MB5990.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(6133799003)(261009223327099003)(261009220027099003)(261009221227099003)(261009221727099003)(261009223027099003)(22082099003)(18002099003)(56012099006)(11063799006)(261028144727099003)(261102123227099003)(261026140227099003)(261026121527099003)(261022075727099003)(261021123027099003)(261021121427099003)(261022105027099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?F9NfXMgq0M9Z/FCPkDT+xgodpLf+xce6PML36MbOHbJxBq33BIt6X/fB2E0s?=
 =?us-ascii?Q?E4t3qqgIqJyRVxrDbtcdrpRVkXH+pTIyoJq8ke0XY5LfyefwDgGuQSH6/HI2?=
 =?us-ascii?Q?7nRW0PvFq4sbCfmGO6AYtODoQV0nMmbUWy/+0x3FCLNHubHYuvI6nEVHQr8b?=
 =?us-ascii?Q?ghGWc5iGuHX0PmWb+Eqk1WGnTfgMjc4nE+cjdol5UchlE9Nr33AFI11UoEos?=
 =?us-ascii?Q?D7r85JjIBPmBQlCNWXWZdf8+ttTbfOfgEvzCWzsQpNC4dV4AsWucdKo552is?=
 =?us-ascii?Q?Dt4RdoJY12YFZBx3VsGnnRohbkNAWy23NivmhDflE724DKtBFYBRgURZdLFS?=
 =?us-ascii?Q?oecdQC2tdpVTjzWVtVLnYddTl8kDIw5AZ9hNzrjpprAjeVqExBrTDLJis1yA?=
 =?us-ascii?Q?CdOmQLARu9j5hONkJ8DIshqpR72eI8EZvvulXVA9uu/iK/p+vM2JdcS1hXyx?=
 =?us-ascii?Q?VAa5YasVTaLvXhdl+dQXNZyi8I9LvstRUWLPUxs9TTSn95iCQZZtnV5U1UZY?=
 =?us-ascii?Q?AY6lnymumkmt0i/cD32eW9p2P3WnnpEhA5qhpfrJ+P6pCj1qzVLwU3LKODnO?=
 =?us-ascii?Q?ELDSnivU66sRedBlzsJ7OTrllWVkUkeuiaSKOQBLF/5d8jC9hr02xdrJooWb?=
 =?us-ascii?Q?Kg5Od0P3x94tKsH2SGzcp6OWp7MEVaVrXHJ9fhqEx5IaFwLwQpPr2CgLRaug?=
 =?us-ascii?Q?oFZSLx5bXzchh2DI2Fc0O+d60L6for3xLOcDdCsjjuxZZfpa22da1sHxqVl6?=
 =?us-ascii?Q?IALoaMfHwt0EfrPrsO5h+p5miro0u4IszTlle2ru0DTEgWU6r9QesPfm1jSK?=
 =?us-ascii?Q?BsuSPbbH6eH+THxE+N/wdQMK7Ft4Jud1kA5byt711cB2BNO9Y1H5IRRE8WT9?=
 =?us-ascii?Q?S/78xAQq2v7u4ZHDtRfkUAgz4IxbLOl4VRh8pSTAkbl9mC9LbZ5aoItLjlRv?=
 =?us-ascii?Q?xcWIafe6VLWMyy36ddtGwLGNM334HhGQHnv7+rbqT5hP0RQPl0aIDaVvJag6?=
 =?us-ascii?Q?BAv1mqWWahYDt43/TQczsXwI6bShIX6pILOKTtBlcI+i4BlfXcy8QHFSXo6M?=
 =?us-ascii?Q?cw5LRVMPEVvEL9sAfd8MlrisoheU1JTShwS0sHPRY1xA5S5HCHyu187VhCuQ?=
 =?us-ascii?Q?J5lC4Ey/W78cjjtbirvY9+VMwAKJpDdu/T79wk7tcaatIF0rNQlm5tccM+Uh?=
 =?us-ascii?Q?TNoPMOgQcyz6AVfih0llEHkzcrGpw9pSpZXJ+8+e3oZdIKuR1NiN/AKro8KE?=
 =?us-ascii?Q?DoWWbvuVAvfa9oshfijeiJCEQKMlW/ahu8tGgVuep+FwdiSnEwa4B4XJNJ+y?=
 =?us-ascii?Q?XqZarIH5Vtwrr1nb9yoy3SmLSLIypYl4u9G+Qa9j2FMSSIvFDwsiU9rRQZWa?=
 =?us-ascii?Q?qYU+Oq/b8rUcck0h3QFeuJUmRdLa6vcmACdwaGFU0J7eNgXlkQe5oVaFzzp9?=
 =?us-ascii?Q?pIsAhoW3g4Jlmg2i63nOIGLlFs1M7nKJtUaeoaeB/k7Wd85zv5ezBWiv+H9A?=
 =?us-ascii?Q?dBFH9tnO9SJ20aCCiMzKweBJc78mxx9YpaGoLh//HGUPY3rqIl8drVCdB4Pr?=
 =?us-ascii?Q?kvVJU5WgLDqYF7zdqlS6u5gSCvJyXKdPNIj4WhOZXQn1YsXiua8JaBUVHr+T?=
 =?us-ascii?Q?J7ydPkDUbY1ydhN5bht1mTJUhBFYzvkZoBL8Q7jsepgXuORnCyBd2RQysN/Q?=
 =?us-ascii?Q?TNW6AryBnDAAYJLUxQr9LFzDqb90U0xVTV9O8paLQo+FPeWzuwwrYJAJaXf7?=
 =?us-ascii?Q?r2Z6p2c0bg=3D=3D?=
X-Exchange-RoutingPolicyChecked: m1EU7hDBEyQy9fajOzDoAVPJTgC9pVjU6hF0oMyopGc9EsExrHV4tXlFRJwYgtEls+LurhmI7PoWotGF9mksga2bRV3qE21nrc2ujiWEEUcs84ksyHszYMk/sK8wCjetftIetHCrpyk/43ShjTeZTna8ee68WtKmLBEGETdjw1k5y90yAWXzMI39SATSm4j8CQuaoMuZWG4CPc9Epo/y/Wltx1BgQKI/EBGQU3oiCA7YJInPNGPfrE1NvhSdrDXXh3qSA/erovWQeP41xK2qfesYDpB3JMkZr/4bIZzX/n/EMDzW9HZN9fNf8PGkMgkJG81CHmWRNQZ1MtVLHg31BA==
X-MS-Exchange-CrossTenant-Network-Message-Id: f224fc51-30fa-4c72-368c-08df4a6aebf8
X-MS-Exchange-CrossTenant-AuthSource: DS7PR11MB5990.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 20:38:39.8419 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kjRFjXAB0NoQly0mhJUBVlwcYOKDfduZAM+Ez45DGURe7f6HBxLaw+nPDyfQYsNrwEYOfCr04KMaCtvbJMMU5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6249
X-OriginatorOrg: intel.com
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Aravind Iddamsetty <aravind.iddamsetty@linux.intel.com>

Add a retired-pages node type to drm-ras so drivers can report the
memory pages they have taken out of service, with two operations:

 - get-retired-pages: dump one entry per page with its address, size
   and status (retired, pending or failed). The dump is flagged with
   NLM_F_DUMP_INTR if the list changes while it is read.
 - get-retired-pages-info: return the maximum number of pages that can
   be retired.

v3 (Rodrigo+LLM):
 - Split the drm-ras core from the xe user.
 - Flatten the page attributes and name the node type retired-pages
   instead of retired-resources, avoiding the over-wrapping
   anti-pattern pointed out by Jakub: the type-specific nest and the
   resource-type enum are gone.
 - Use uint for address, size and max-pages, no pad (Jakub).
 - Start the status enum at 1.
 - Move max-pages to its own do operation instead of a leading dump
   entry.
 - Set NLM_F_DUMP_INTR from a driver generation counter.
 - Report unknown node IDs with NL_SET_BAD_ATTR.
 - Removed deprecated Assisted-by tag.

v4 (Rodrigo+LLM):
 - Check the dump consistency once a page message is filled (Sashiko),
   and on the final NLMSG_DONE (local Sashiko), so NLM_F_DUMP_INTR is
   not lost.
 - Make the error-counter operations reject other node types (Sashiko).
 - Hold a node reference in the new handlers (local Sashiko).
 - Rebase on the telemetry node type, moving the type check of its
   handlers into drm_ras_node_get().

Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Riana Tauro <riana.tauro@intel.com>
Cc: Raag Jadav <raag.jadav@intel.com>
Cc: Zack McKevitt <zachary.mckevitt@oss.qualcomm.com>
Cc: Jeff Hugo <jeff.hugo@oss.qualcomm.com>
Signed-off-by: Aravind Iddamsetty <aravind.iddamsetty@linux.intel.com>
Signed-off-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
---
 Documentation/netlink/specs/drm_ras.yaml |  74 +++++++-
 drivers/gpu/drm/drm_ras.c                | 226 +++++++++++++++++++++--
 drivers/gpu/drm/drm_ras_nl.c             |  24 +++
 drivers/gpu/drm/drm_ras_nl.h             |   4 +
 include/drm/drm_ras.h                    |  49 +++++
 include/uapi/drm/drm_ras.h               |  31 +++-
 6 files changed, 388 insertions(+), 20 deletions(-)

diff --git a/Documentation/netlink/specs/drm_ras.yaml b/Documentation/netlink/specs/drm_ras.yaml
index 0f1ceb705d3d..bc17d22e2156 100644
--- a/Documentation/netlink/specs/drm_ras.yaml
+++ b/Documentation/netlink/specs/drm_ras.yaml
@@ -16,16 +16,28 @@ definitions:
     type: enum
     name: node-type
     value-start: 1
-    entries: [error-counter, telemetry]
+    entries: [error-counter, telemetry, retired-pages]
     doc: >-
          Type of the node. The error-counter nodes expose reliability counters
-         for a hardware/software component, and telemetry nodes expose an
-         interface for reading and writing telemetry values to a device.
+         for a hardware/software component, telemetry nodes expose an
+         interface for reading and writing telemetry values to a device, and
+         retired-pages nodes list the memory pages that have been taken out
+         of service.
   -
     type: flags
     name: telemetry-field-mode
     entries: [read, write]
     doc: Bitmask of access modes supported by a telemetry field.
+  -
+    type: enum
+    name: retired-page-status
+    value-start: 1
+    entries: [retired, pending, failed]
+    doc: >-
+         Status of a retired page. retired means the page is reserved and out
+         of service; pending means the retirement is queued but the
+         reservation is not complete yet; failed means the reservation failed
+         and the page may still be in use.
 
 attribute-sets:
   -
@@ -140,6 +152,30 @@ attribute-sets:
         doc: >-
              Bitmask of access modes (read/write) supported by the
              telemetry field.
+  -
+    name: retired-page-attrs
+    attributes:
+      -
+        name: node-id
+        type: u32
+        doc: Node ID targeted by this retired pages operation.
+      -
+        name: address
+        type: uint
+        doc: Device address of the retired page.
+      -
+        name: size
+        type: uint
+        doc: Size of the retired page in bytes.
+      -
+        name: status
+        type: u32
+        doc: Retirement status of the page.
+        enum: retired-page-status
+      -
+        name: max-pages
+        type: uint
+        doc: Maximum number of pages that can be retired on this node.
 
 operations:
   list:
@@ -287,6 +323,38 @@ operations:
             - field
             - field-name
             - mode
+    -
+      name: get-retired-pages
+      doc: >-
+           Retrieve the pages retired on a retired-pages node, one entry per
+           page. The dump is flagged as interrupted if the list changes while
+           it is being read.
+      attribute-set: retired-page-attrs
+      flags: [admin-perm]
+      dump:
+        request:
+          attributes:
+            - node-id
+        reply:
+          attributes:
+            - node-id
+            - address
+            - size
+            - status
+    -
+      name: get-retired-pages-info
+      doc: >-
+           Retrieve the retired page limits of a retired-pages node.
+      attribute-set: retired-page-attrs
+      flags: [admin-perm]
+      do:
+        request:
+          attributes:
+            - node-id
+        reply:
+          attributes:
+            - node-id
+            - max-pages
 
 mcast-groups:
   list:
diff --git a/drivers/gpu/drm/drm_ras.c b/drivers/gpu/drm/drm_ras.c
index 82fcc766b84b..b6e203448d22 100644
--- a/drivers/gpu/drm/drm_ras.c
+++ b/drivers/gpu/drm/drm_ras.c
@@ -69,6 +69,14 @@
  *     Each field contains the uAPI defined enum string, its numerical value,
  *     and its mode bitmask, which encodes read/write capabilities.
  *
+ * 11. GET_RETIRED_PAGES: Dump the retired pages of a given node.
+ *     Userspace must provide Node ID.
+ *     Returns one entry per page with its address, size and status.
+ *
+ * 12. GET_RETIRED_PAGES_INFO: Get the retired page limits of a given node.
+ *     Userspace must provide Node ID.
+ *     Returns the maximum number of pages that can be retired.
+ *
  * Node registration:
  *
  * - drm_ras_node_register(): Registers a new node and assigns
@@ -121,6 +129,13 @@
  *     + The driver can optionally provide a pre_doit callback, telemetry_pre(),
  *       to enforce permissions checks on telemetry operations.
  *
+ * - RETIRED_PAGES:
+ *     + The driver must implement the query_retired_page() callback, returning
+ *       the retired page with the lowest address at or above a cursor, and
+ *       -ENOENT when there is none.
+ *     + The driver can implement query_retired_pages_info() to report the
+ *       maximum number of pages that can be retired.
+ *
  * Netlink handlers:
  *
  * - drm_ras_nl_list_nodes_dumpit(): Implements the LIST_NODES
@@ -147,6 +162,10 @@
  * - drm_ras_nl_telemetry_list_fields_dumpit(): Implements the TELEMETRY_LIST_FIELDS
  *   dumpit operation, enumerating all telemetry fields and their supported
  *   access modes for a telemetry node.
+ * - drm_ras_nl_get_retired_pages_dumpit(): Implements the GET_RETIRED_PAGES dumpit
+ *   operation, listing the retired pages of a specific node.
+ * - drm_ras_nl_get_retired_pages_info_doit(): Implements the GET_RETIRED_PAGES_INFO
+ *   doit operation, fetching the retired page limits of a specific node.
  */
 
 static DEFINE_XARRAY_ALLOC(drm_ras_xa);
@@ -162,6 +181,8 @@ struct drm_ras_ctx {
 	unsigned long restart;
 	/* Node targeted by a telemetry get/set doit */
 	struct drm_ras_node *node;
+	/* Which retired page address to restart the dump from */
+	u64 cursor;
 };
 
 static_assert(sizeof(struct drm_ras_ctx) <= NETLINK_CTX_SIZE);
@@ -169,6 +190,7 @@ static_assert(sizeof(struct drm_ras_ctx) <= NETLINK_CTX_SIZE);
 /**
  * drm_ras_node_get() - Look up a RAS node by ID and take a reference
  * @node_id: ID of the node to look up
+ * @type: Expected type of the node
  *
  * Looks the node up in the global xarray and, if found, takes a reference to
  * it so that it cannot be freed while the caller is using it. The lookup and
@@ -179,16 +201,19 @@ static_assert(sizeof(struct drm_ras_ctx) <= NETLINK_CTX_SIZE);
  *
  * The caller must drop the returned reference with drm_ras_node_put().
  *
- * Return: the referenced node, or NULL if no node with @node_id is registered.
+ * Return: the referenced node, or NULL if no node of @type with @node_id is
+ * registered.
  */
-static struct drm_ras_node *drm_ras_node_get(u32 node_id)
+static struct drm_ras_node *drm_ras_node_get(u32 node_id, enum drm_ras_node_type type)
 {
 	struct drm_ras_node *node;
 
 	xa_lock(&drm_ras_xa);
 	node = xa_load(&drm_ras_xa, node_id);
-	if (node)
+	if (node && node->type == type)
 		refcount_inc(&node->ref);
+	else
+		node = NULL;
 	xa_unlock(&drm_ras_xa);
 
 	return node;
@@ -412,7 +437,7 @@ static int doit_reply_value(struct genl_info *info, u32 node_id,
 	u32 value;
 	int ret;
 
-	node = drm_ras_node_get(node_id);
+	node = drm_ras_node_get(node_id, DRM_RAS_NODE_TYPE_ERROR_COUNTER);
 	if (!node)
 		return -ENOENT;
 
@@ -461,7 +486,7 @@ static int doit_reply_threshold(struct genl_info *info, u32 node_id, u32 error_i
 	u32 threshold;
 	int ret;
 
-	node = drm_ras_node_get(node_id);
+	node = drm_ras_node_get(node_id, DRM_RAS_NODE_TYPE_ERROR_COUNTER);
 	if (!node)
 		return -ENOENT;
 
@@ -603,7 +628,7 @@ int drm_ras_nl_get_error_counter_dumpit(struct sk_buff *skb,
 
 	node_id = nla_get_u32(info->attrs[DRM_RAS_A_ERROR_COUNTER_ATTRS_NODE_ID]);
 
-	node = drm_ras_node_get(node_id);
+	node = drm_ras_node_get(node_id, DRM_RAS_NODE_TYPE_ERROR_COUNTER);
 	if (!node)
 		return -ENOENT;
 
@@ -699,7 +724,7 @@ int drm_ras_nl_clear_error_counter_doit(struct sk_buff *skb,
 	node_id = nla_get_u32(info->attrs[DRM_RAS_A_ERROR_COUNTER_ATTRS_NODE_ID]);
 	error_id = nla_get_u32(info->attrs[DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_ID]);
 
-	node = drm_ras_node_get(node_id);
+	node = drm_ras_node_get(node_id, DRM_RAS_NODE_TYPE_ERROR_COUNTER);
 	if (!node || !node->clear_error_counter) {
 		drm_ras_node_put(node);
 		return -ENOENT;
@@ -770,7 +795,7 @@ int drm_ras_nl_set_error_threshold_doit(struct sk_buff *skb, struct genl_info *i
 	error_id = nla_get_u32(info->attrs[DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_ID]);
 	threshold = nla_get_u32(info->attrs[DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_THRESHOLD]);
 
-	node = drm_ras_node_get(node_id);
+	node = drm_ras_node_get(node_id, DRM_RAS_NODE_TYPE_ERROR_COUNTER);
 	if (!node)
 		return -ENOENT;
 
@@ -781,6 +806,176 @@ int drm_ras_nl_set_error_threshold_doit(struct sk_buff *skb, struct genl_info *i
 	return ret;
 }
 
+static struct drm_ras_node *get_retired_pages_node(const struct genl_info *info)
+{
+	struct nlattr *attr = info->attrs[DRM_RAS_A_RETIRED_PAGE_ATTRS_NODE_ID];
+	struct drm_ras_node *node;
+
+	node = drm_ras_node_get(nla_get_u32(attr), DRM_RAS_NODE_TYPE_RETIRED_PAGES);
+	if (!node)
+		NL_SET_BAD_ATTR(info->extack, attr);
+
+	return node;
+}
+
+static int msg_put_retired_page(struct sk_buff *msg, u32 node_id,
+				const struct drm_ras_retired_page *page)
+{
+	int ret;
+
+	ret = nla_put_u32(msg, DRM_RAS_A_RETIRED_PAGE_ATTRS_NODE_ID, node_id);
+	if (ret)
+		return ret;
+
+	ret = nla_put_uint(msg, DRM_RAS_A_RETIRED_PAGE_ATTRS_ADDRESS, page->address);
+	if (ret)
+		return ret;
+
+	ret = nla_put_uint(msg, DRM_RAS_A_RETIRED_PAGE_ATTRS_SIZE, page->size);
+	if (ret)
+		return ret;
+
+	return nla_put_u32(msg, DRM_RAS_A_RETIRED_PAGE_ATTRS_STATUS, page->status);
+}
+
+static int dump_retired_pages(struct sk_buff *skb, struct netlink_callback *cb,
+			      struct drm_ras_node *node)
+{
+	const struct genl_info *info = genl_info_dump(cb);
+	struct drm_ras_ctx *ctx = (void *)cb->ctx;
+	struct drm_ras_retired_page page;
+	void *hdr;
+	int ret;
+
+	for (;;) {
+		ret = node->query_retired_page(node, ctx->cursor, &page);
+		if (ret && ret != -ENOENT)
+			return ret;
+
+		/* Never zero, so the first message is checked as well */
+		cb->seq = page.generation + 1;
+		if (ret == -ENOENT)
+			return 0;
+
+		hdr = genlmsg_iput(skb, info);
+		if (!hdr)
+			return -EMSGSIZE;
+
+		ret = msg_put_retired_page(skb, node->id, &page);
+		if (ret) {
+			genlmsg_cancel(skb, hdr);
+			return ret;
+		}
+
+		genl_dump_check_consistent(cb, hdr);
+
+		genlmsg_end(skb, hdr);
+		ctx->cursor = page.address + 1;
+	}
+}
+
+/**
+ * drm_ras_nl_get_retired_pages_dumpit() - Dump the retired pages of a node
+ * @skb: Netlink message buffer
+ * @cb: Callback context for multi-part dumps
+ *
+ * Appends one message per retired page, in increasing address order. The
+ * dump resumes from the next address after a buffer overflow, and is flagged
+ * with %NLM_F_DUMP_INTR if the list changed between messages.
+ *
+ * Return: 0 if all pages fit in @skb, -EMSGSIZE if the buffer filled up
+ *         (requires multi-part continuation), or a negative error code on
+ *         failure.
+ */
+int drm_ras_nl_get_retired_pages_dumpit(struct sk_buff *skb,
+					struct netlink_callback *cb)
+{
+	const struct genl_info *info = genl_info_dump(cb);
+	struct drm_ras_node *node;
+	int ret;
+
+	if (!info->attrs || GENL_REQ_ATTR_CHECK(info, DRM_RAS_A_RETIRED_PAGE_ATTRS_NODE_ID))
+		return -EINVAL;
+
+	node = get_retired_pages_node(info);
+	if (!node)
+		return -ENOENT;
+
+	ret = dump_retired_pages(skb, cb, node);
+	drm_ras_node_put(node);
+
+	return ret;
+}
+
+static int doit_reply_retired_pages_info(struct genl_info *info, struct drm_ras_node *node)
+{
+	struct sk_buff *msg;
+	u64 max_pages;
+	void *hdr;
+	int ret;
+
+	if (!node->query_retired_pages_info)
+		return -EOPNOTSUPP;
+
+	ret = node->query_retired_pages_info(node, &max_pages);
+	if (ret)
+		return ret;
+
+	msg = genlmsg_new(NLMSG_GOODSIZE, GFP_KERNEL);
+	if (!msg)
+		return -ENOMEM;
+
+	hdr = genlmsg_iput(msg, info);
+	if (!hdr) {
+		ret = -EMSGSIZE;
+		goto free_msg;
+	}
+
+	ret = nla_put_u32(msg, DRM_RAS_A_RETIRED_PAGE_ATTRS_NODE_ID, node->id);
+	if (ret)
+		goto cancel_msg;
+
+	ret = nla_put_uint(msg, DRM_RAS_A_RETIRED_PAGE_ATTRS_MAX_PAGES, max_pages);
+	if (ret)
+		goto cancel_msg;
+
+	genlmsg_end(msg, hdr);
+
+	return genlmsg_reply(msg, info);
+
+cancel_msg:
+	genlmsg_cancel(msg, hdr);
+free_msg:
+	nlmsg_free(msg);
+	return ret;
+}
+
+/**
+ * drm_ras_nl_get_retired_pages_info_doit() - Query the retired page limits of a node
+ * @skb: Netlink message buffer
+ * @info: Generic Netlink info containing attributes of the request
+ *
+ * Return: 0 on success, or negative errno on failure.
+ */
+int drm_ras_nl_get_retired_pages_info_doit(struct sk_buff *skb,
+					   struct genl_info *info)
+{
+	struct drm_ras_node *node;
+	int ret;
+
+	if (!info->attrs || GENL_REQ_ATTR_CHECK(info, DRM_RAS_A_RETIRED_PAGE_ATTRS_NODE_ID))
+		return -EINVAL;
+
+	node = get_retired_pages_node(info);
+	if (!node)
+		return -ENOENT;
+
+	ret = doit_reply_retired_pages_info(info, node);
+	drm_ras_node_put(node);
+
+	return ret;
+}
+
 /**
  * drm_ras_nl_pre_telemetry - Look up the telemetry node and enforce permissions
  * @ops: Generic netlink operations
@@ -808,10 +1003,9 @@ int drm_ras_nl_pre_telemetry(const struct genl_split_ops *ops, struct sk_buff *s
 		return -EINVAL;
 
 	node_id = nla_get_u32(info->attrs[DRM_RAS_A_TELEMETRY_ATTRS_NODE_ID]);
-	node = drm_ras_node_get(node_id);
-	if (!node || node->type != DRM_RAS_NODE_TYPE_TELEMETRY) {
+	node = drm_ras_node_get(node_id, DRM_RAS_NODE_TYPE_TELEMETRY);
+	if (!node) {
 		NL_SET_BAD_ATTR(info->extack, info->attrs[DRM_RAS_A_TELEMETRY_ATTRS_NODE_ID]);
-		drm_ras_node_put(node);
 		return -ENOENT;
 	}
 
@@ -892,10 +1086,9 @@ int drm_ras_nl_telemetry_list_fields_dumpit(struct sk_buff *skb, struct netlink_
 
 	node_id = nla_get_u32(info->attrs[DRM_RAS_A_TELEMETRY_ATTRS_NODE_ID]);
 
-	node = drm_ras_node_get(node_id);
-	if (!node || node->type != DRM_RAS_NODE_TYPE_TELEMETRY) {
+	node = drm_ras_node_get(node_id, DRM_RAS_NODE_TYPE_TELEMETRY);
+	if (!node) {
 		NL_SET_BAD_ATTR(info->extack, info->attrs[DRM_RAS_A_TELEMETRY_ATTRS_NODE_ID]);
-		drm_ras_node_put(node);
 		return -ENOENT;
 	}
 
@@ -1100,7 +1293,6 @@ int drm_ras_node_register(struct drm_ras_node *node)
 	if (!node->device_name || !node->node_name)
 		return -EINVAL;
 
-	/* Currently, only Error Counter and Telemetry endpoints are supported */
 	switch (node->type) {
 	case DRM_RAS_NODE_TYPE_ERROR_COUNTER:
 		/* Mandatory entries for Error Counter Node */
@@ -1112,6 +1304,10 @@ int drm_ras_node_register(struct drm_ras_node *node)
 		if (!node->telemetry_get || !node->telemetry_fields)
 			return -EINVAL;
 		break;
+	case DRM_RAS_NODE_TYPE_RETIRED_PAGES:
+		if (!node->query_retired_page)
+			return -EINVAL;
+		break;
 	default:
 		return -EINVAL;
 	}
diff --git a/drivers/gpu/drm/drm_ras_nl.c b/drivers/gpu/drm/drm_ras_nl.c
index 589c6445eff7..c56220205876 100644
--- a/drivers/gpu/drm/drm_ras_nl.c
+++ b/drivers/gpu/drm/drm_ras_nl.c
@@ -59,6 +59,16 @@ static const struct nla_policy drm_ras_telemetry_list_fields_nl_policy[DRM_RAS_A
 	[DRM_RAS_A_TELEMETRY_ATTRS_NODE_ID] = { .type = NLA_U32, },
 };
 
+/* DRM_RAS_CMD_GET_RETIRED_PAGES - dump */
+static const struct nla_policy drm_ras_get_retired_pages_nl_policy[DRM_RAS_A_RETIRED_PAGE_ATTRS_NODE_ID + 1] = {
+	[DRM_RAS_A_RETIRED_PAGE_ATTRS_NODE_ID] = { .type = NLA_U32, },
+};
+
+/* DRM_RAS_CMD_GET_RETIRED_PAGES_INFO - do */
+static const struct nla_policy drm_ras_get_retired_pages_info_nl_policy[DRM_RAS_A_RETIRED_PAGE_ATTRS_NODE_ID + 1] = {
+	[DRM_RAS_A_RETIRED_PAGE_ATTRS_NODE_ID] = { .type = NLA_U32, },
+};
+
 /* Ops table for drm_ras */
 static const struct genl_split_ops drm_ras_nl_ops[] = {
 	{
@@ -126,6 +136,20 @@ static const struct genl_split_ops drm_ras_nl_ops[] = {
 		.maxattr	= DRM_RAS_A_TELEMETRY_ATTRS_NODE_ID,
 		.flags		= GENL_CMD_CAP_DUMP,
 	},
+	{
+		.cmd		= DRM_RAS_CMD_GET_RETIRED_PAGES,
+		.dumpit		= drm_ras_nl_get_retired_pages_dumpit,
+		.policy		= drm_ras_get_retired_pages_nl_policy,
+		.maxattr	= DRM_RAS_A_RETIRED_PAGE_ATTRS_NODE_ID,
+		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DUMP,
+	},
+	{
+		.cmd		= DRM_RAS_CMD_GET_RETIRED_PAGES_INFO,
+		.doit		= drm_ras_nl_get_retired_pages_info_doit,
+		.policy		= drm_ras_get_retired_pages_info_nl_policy,
+		.maxattr	= DRM_RAS_A_RETIRED_PAGE_ATTRS_NODE_ID,
+		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
+	},
 };
 
 static const struct genl_multicast_group drm_ras_nl_mcgrps[] = {
diff --git a/drivers/gpu/drm/drm_ras_nl.h b/drivers/gpu/drm/drm_ras_nl.h
index 7a1cba70fd50..880b0c2befe3 100644
--- a/drivers/gpu/drm/drm_ras_nl.h
+++ b/drivers/gpu/drm/drm_ras_nl.h
@@ -34,6 +34,10 @@ int drm_ras_nl_telemetry_get_doit(struct sk_buff *skb, struct genl_info *info);
 int drm_ras_nl_telemetry_set_doit(struct sk_buff *skb, struct genl_info *info);
 int drm_ras_nl_telemetry_list_fields_dumpit(struct sk_buff *skb,
 					    struct netlink_callback *cb);
+int drm_ras_nl_get_retired_pages_dumpit(struct sk_buff *skb,
+					struct netlink_callback *cb);
+int drm_ras_nl_get_retired_pages_info_doit(struct sk_buff *skb,
+					   struct genl_info *info);
 
 enum {
 	DRM_RAS_NLGRP_ERROR_REPORT,
diff --git a/include/drm/drm_ras.h b/include/drm/drm_ras.h
index 76bdcc6f96a5..5c3900a53278 100644
--- a/include/drm/drm_ras.h
+++ b/include/drm/drm_ras.h
@@ -28,6 +28,23 @@ struct drm_ras_telemetry_field {
 	u32 mode;
 };
 
+/**
+ * struct drm_ras_retired_page - A retired page reported by a driver
+ */
+struct drm_ras_retired_page {
+	/** @address: Device address of the page. */
+	u64 address;
+	/** @size: Size of the page in bytes. */
+	u64 size;
+	/** @status: Retirement status (enum drm_ras_retired_page_status). */
+	enum drm_ras_retired_page_status status;
+	/**
+	 * @generation: Generation of the retired page list, changed by the
+	 * driver whenever a page is added, removed or changes status.
+	 */
+	u32 generation;
+};
+
 /**
  * struct drm_ras_node - A DRM RAS Node
  */
@@ -184,6 +201,38 @@ struct drm_ras_node {
 	int (*telemetry_set)(struct drm_ras_node *ep, u64 *field, s64 *value,
 			     s64 *status);
 
+	/* Retired-Pages Related Callbacks */
+
+	/**
+	 * @query_retired_page:
+	 *
+	 * This callback is used by drm-ras to list the retired pages of a node.
+	 * It must fill @page with the retired page that has the lowest address
+	 * greater than or equal to @cursor. @page->generation must be set even
+	 * when no page is found.
+	 *
+	 * The @query_retired_page is a mandatory callback for
+	 * retired_pages_node.
+	 *
+	 * Returns: 0 on success,
+	 *          -ENOENT when no page is at or above @cursor, which ends the
+	 *                  list.
+	 *          Other negative values on errors that should terminate the
+	 *          netlink query.
+	 */
+	int (*query_retired_page)(struct drm_ras_node *node, u64 cursor,
+				  struct drm_ras_retired_page *page);
+
+	/**
+	 * @query_retired_pages_info:
+	 *
+	 * This callback is used by drm-ras to query the maximum number of pages
+	 * that can be retired on a node.
+	 *
+	 * Returns: 0 on success, negative error code on failure.
+	 */
+	int (*query_retired_pages_info)(struct drm_ras_node *node, u64 *max_pages);
+
 	/** @priv: Driver private data */
 	void *priv;
 
diff --git a/include/uapi/drm/drm_ras.h b/include/uapi/drm/drm_ras.h
index 56e0588af5d5..e7f2da18cc4c 100644
--- a/include/uapi/drm/drm_ras.h
+++ b/include/uapi/drm/drm_ras.h
@@ -12,12 +12,14 @@
 
 /*
  * Type of the node. The error-counter nodes expose reliability counters for a
- * hardware/software component, and telemetry nodes expose an interface for
- * reading and writing telemetry values to a device.
+ * hardware/software component, telemetry nodes expose an interface for reading
+ * and writing telemetry values to a device, and retired-pages nodes list the
+ * memory pages that have been taken out of service.
  */
 enum drm_ras_node_type {
 	DRM_RAS_NODE_TYPE_ERROR_COUNTER = 1,
 	DRM_RAS_NODE_TYPE_TELEMETRY,
+	DRM_RAS_NODE_TYPE_RETIRED_PAGES,
 };
 
 /*
@@ -28,6 +30,18 @@ enum drm_ras_telemetry_field_mode {
 	DRM_RAS_TELEMETRY_FIELD_MODE_WRITE = 2,
 };
 
+/*
+ * Status of a retired page. retired means the page is reserved and out of
+ * service; pending means the retirement is queued but the reservation is not
+ * complete yet; failed means the reservation failed and the page may still be
+ * in use.
+ */
+enum drm_ras_retired_page_status {
+	DRM_RAS_RETIRED_PAGE_STATUS_RETIRED = 1,
+	DRM_RAS_RETIRED_PAGE_STATUS_PENDING,
+	DRM_RAS_RETIRED_PAGE_STATUS_FAILED,
+};
+
 enum {
 	DRM_RAS_A_NODE_ATTRS_NODE_ID = 1,
 	DRM_RAS_A_NODE_ATTRS_DEVICE_NAME,
@@ -73,6 +87,17 @@ enum {
 	DRM_RAS_A_TELEMETRY_ATTRS_MAX = (__DRM_RAS_A_TELEMETRY_ATTRS_MAX - 1)
 };
 
+enum {
+	DRM_RAS_A_RETIRED_PAGE_ATTRS_NODE_ID = 1,
+	DRM_RAS_A_RETIRED_PAGE_ATTRS_ADDRESS,
+	DRM_RAS_A_RETIRED_PAGE_ATTRS_SIZE,
+	DRM_RAS_A_RETIRED_PAGE_ATTRS_STATUS,
+	DRM_RAS_A_RETIRED_PAGE_ATTRS_MAX_PAGES,
+
+	__DRM_RAS_A_RETIRED_PAGE_ATTRS_MAX,
+	DRM_RAS_A_RETIRED_PAGE_ATTRS_MAX = (__DRM_RAS_A_RETIRED_PAGE_ATTRS_MAX - 1)
+};
+
 enum {
 	DRM_RAS_CMD_LIST_NODES = 1,
 	DRM_RAS_CMD_GET_ERROR_COUNTER,
@@ -83,6 +108,8 @@ enum {
 	DRM_RAS_CMD_TELEMETRY_GET,
 	DRM_RAS_CMD_TELEMETRY_SET,
 	DRM_RAS_CMD_TELEMETRY_LIST_FIELDS,
+	DRM_RAS_CMD_GET_RETIRED_PAGES,
+	DRM_RAS_CMD_GET_RETIRED_PAGES_INFO,
 
 	__DRM_RAS_CMD_MAX,
 	DRM_RAS_CMD_MAX = (__DRM_RAS_CMD_MAX - 1)
-- 
2.56.0

