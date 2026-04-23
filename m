Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F193FAD3E3
	for <dri-devel@archiver.kernel.org>; Thu, 23 Apr 2026 06:27:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4177010E06A;
	Thu, 23 Apr 2026 06:27:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="QvQfhF4R";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3BE1C10E06A;
 Thu, 23 Apr 2026 06:27:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1776925668; x=1808461668;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=Hj6+poo+J+KpsJ3efbLmWF5GZu0zHjFIzwK11FsUMNA=;
 b=QvQfhF4RFzUZ6edDd1DkPEzzKIR6f9lo2ZcgegLnTx9Mt0FkzeZ2Hd/F
 neQO8h9vvouTPITsfO3lN1aztSI/w3B2Bw1VvXorTZa1wqM/WudW1V0le
 D0jWsqALt9hsi6JZlnf8DgMZIVOJqaHIhnWUZ41INOZdRqxmjCKCA5INs
 IyXRG+MFSs3eOHkSY+kqXD4FPoh7tE0ThJTpb+65Ct3qJJnP45QoCpKcp
 CRCSzx/HMc6IMaQ/59X0CFvuw9BXBBp4DvWK21kO9fAtibqnSp++BulDJ
 yzxHkAMU9VYM4VqCv86nO2QT12lk/4nyVE5R2W+WMnNF3cLh1hAzjcUJ2 Q==;
X-CSE-ConnectionGUID: 7TlrpedESyC+iKvKsONqjA==
X-CSE-MsgGUID: eoFUZXAhQJSVMNO/oSYgiA==
X-IronPort-AV: E=McAfee;i="6800,10657,11764"; a="88967324"
X-IronPort-AV: E=Sophos;i="6.23,194,1770624000"; d="scan'208";a="88967324"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Apr 2026 23:27:48 -0700
X-CSE-ConnectionGUID: psBnDnOrTjicLl6qpgCzCw==
X-CSE-MsgGUID: xdH9p2MKQe+UXIuzhIgqCw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,194,1770624000"; d="scan'208";a="236936278"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Apr 2026 23:27:48 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 22 Apr 2026 23:27:47 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 22 Apr 2026 23:27:47 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.2) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 22 Apr 2026 23:27:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GsMFzIX4BHWKq7BtA7e2lbbulKh11Mjjtoum3CbtkL/PtDjihP2z0lIyXxfTFf4jwp8ksGqsMbIiMqkeUVHaGe29V/xJ+J/lB++7c3k04JfP84DNRTA++WO/u5VNq2G9eX/zJ4e8HiP95t8yJqzIBnfi9rw+09roaesvkEi1kIJv+IyDbHSawTNJxbRZwI2vhni0IspjTdTYF8hm/eiH/hP5TA+8DbLPRnyGy3vh8XvoC+qN0X2W50yMBPbQWv+7lemxZ7DRgLjoyUL4ibzmZ3OJ/wegHbPsXUo6U1MVwroSUB9QObyNIQzFzyxTtWj52PQ0pwrBTMLcO0IC9/Tb3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5CceT1jeKpnazaYBkpHSJkQbaDUuhCiyJvt/RLQ5D3Q=;
 b=MznjxXTS+OTLAbeAnaYxXRAUdKmlHGbWLc5g4kOw8zC43JJ3FmZud/F9zZZRJD++H1Svo2AnGxLv/atJ/a8OpGCQLwwMZH99aV77gDYj3hkUaFTD4er/K11eIayw6QYR+JhGV2rwCidQLxQhP+R6d7Q0Wqk4463WPan0qtVvQG6KX9TZ47LSzvlxYpBXD+3mo8iU6XJkmpETBxwTIceU2Pqy9QcUmfciF57b4I1R9TEW9RroJV27UsK5GujMf6GmkDON1f4cnvv/3zo1C8sqAY/DGnYnIVuxG2HfGyGayF5WXWTmSOI/VA2MN1AzxRu21GkpAvDgofzfpovzScKCSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6522.namprd11.prod.outlook.com (2603:10b6:510:212::12)
 by DM3PPF1721FD39C.namprd11.prod.outlook.com (2603:10b6:f:fc00::f0a)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.21; Thu, 23 Apr
 2026 06:27:37 +0000
Received: from PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c]) by PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c%7]) with mapi id 15.20.9846.021; Thu, 23 Apr 2026
 06:27:37 +0000
Date: Wed, 22 Apr 2026 23:27:34 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: Balbir Singh <balbirs@nvidia.com>
CC: <intel-xe@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
 Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand
 <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, "Liam R. Howlett"
 <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport
 <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal Hocko
 <mhocko@suse.com>, <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/5] mm: Introduce zone_appears_fragmented()
Message-ID: <aem71qmZaq7jQnSF@gsse-cloud1.jf.intel.com>
References: <20260423055656.1696379-1-matthew.brost@intel.com>
 <20260423055656.1696379-2-matthew.brost@intel.com>
 <b0bd6cdc-511e-4fad-959d-3fa75c865aa8@nvidia.com>
 <aem5RcHbj5zcKbsw@gsse-cloud1.jf.intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aem5RcHbj5zcKbsw@gsse-cloud1.jf.intel.com>
X-ClientProxiedBy: BY5PR03CA0009.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::19) To PH7PR11MB6522.namprd11.prod.outlook.com
 (2603:10b6:510:212::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6522:EE_|DM3PPF1721FD39C:EE_
X-MS-Office365-Filtering-Correlation-Id: 396f8743-2f61-432b-703c-08dea1016982
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7416014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: ol9m6QzdGsByyQxDi4Zg6AgDSXftNdw02lfdn7BMZlGO2PwaRP7NIzJGo4jh5dRbCLpVxv+gHl0RzTRNHF5yN8mkCMub2Ahvi33NR9ZtnB2WI9YLGoliET1PIbXQd2w5WlvsIRn7qrRDtDHeGJ+oTiIOTx6WtvJl9Jsh1h27dgCCSIXz1/CWSCQZHI8xyTgUTG1AUFegHdN/tBJJ6tuwMFijXpKrMpokMVwgz5wdKe51M4MEBxlvYXHWw5j6LbtlACHhS7lBq30RvZJ/9OucAzl/Gh2TUQXA+Py0jaJZHJLCh/9l66TwG9XHNTKlpQFabIjCs1656g3pIlNqyGP/eTmNjUJafBwSbI0UWSSlpXlaiSu9SeBqt8ClwoVToJCEbbSvy9V2reAsxghvUSxUSmc8VVWUGuBqk6IFWnHEHhdMRQmjmCh1Zp4xiIyxDT/WpJwUy9NROOFOMXaVogs1TKxerHgzki4Me8JdQ97cmcTQRavdI7lgGWU28B8Z4g1lh/JJt+DWzSCjytliE5s82rSbMbH+GlzHL1z6G/SiF6/fWPsFCRUgKR8NJySXU7geaEGXg2nJkK6NLOwkpNoLUNw9Oa9p/CQoO0yZaky78IHU8aOryrp2PkbmfNVruyucuNwNeMN77/OQOSYiR3X3umJzI5yAc8Z6nKxikzvp7W0w6lY988j9BC6k04fVlIg8
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR11MB6522.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OXVXSzhVNEpFdGFFSXBaM1k0T0lHUmdyWTJpT3ZIYVJpcnAyS1l0eFM2QlhH?=
 =?utf-8?B?b2VycVlsOHJ2eEhaTkU5NzRxZHVUV3JERWN0cUpEZ1ZBRk1jb2JXRUVWeVFk?=
 =?utf-8?B?UGt5R3M5OWpDZmp5L0dVOVlyS1Q1N0xpcTVuYTM3ZzM4NFB6Uk0wQ08vL3dK?=
 =?utf-8?B?UWFXRDM0WlRIOFowVjhxdXM4cCtRYWc4aE1aaGdXT3BYUjNLMm52TmdyOEF1?=
 =?utf-8?B?YXY3UU9LZC9NN3ZVc0dRVDlHUUJvNFh3d2d3dGpwMFc1dlZIaXI0N3Z3NXMz?=
 =?utf-8?B?N0pLNzJSdzcrejVFV2hpQU96TTRKUnZhNThUV21mQTRldUZ4WEI2V2g5K3Y3?=
 =?utf-8?B?TllzdC9Fa2NTT3R1Qm1iVnNlVE4rUnZyUC9ETTFkY3pjTFBwcklNb2c2ekMx?=
 =?utf-8?B?VGJWZk81emVyaDUxOFUxTWdabjFlU2ZRdG1OUkV1TmU3Rk1jV29DK0RyRTBU?=
 =?utf-8?B?VkxtL2MyR1RzWUVTV2hyeWVHVG4ySTRvb2s5UWNDd3lQdXZhUENTRUpESVo5?=
 =?utf-8?B?dW8zRDIzM1JsakpnblNTWVN6VjFDL0diZjRRNFZCbVVodlZPSVZkV1k1SFNK?=
 =?utf-8?B?TWxnSkIzQ05KaWZvbnlRQlBLeFFkamNvb0pzeDlCQ2FmM3Y4SFlaWFVEdHhN?=
 =?utf-8?B?YUJYMzJkM0RSQXlldkFLR1NaVHhZSzZtMjE3WS9kLzRWZTJEWVh3MVZxYUNk?=
 =?utf-8?B?Z1hUL1kvNTVIbUJSL0ZLdWEyUG9xSWpoVkFmWUs1VVA4ZkZ6bjdwOXhsM25W?=
 =?utf-8?B?UjFldVUvaDNCQVF5c21iaVF6aGdLT2h0dFBTM0FNNWwrSGorRUV6K3Q3cy9q?=
 =?utf-8?B?Nm04NTFxUEdheEgxek5EaTlyM0NWTitUQXdRWldFdXpJVjhZVkhSbzNITjB1?=
 =?utf-8?B?OWFZZG1jKzZmZTFYaWxCZkNkNHRsMU5oUElXcnZkR0lkeXNpdnQ2T1hhQ0xJ?=
 =?utf-8?B?THNVVFBUMDI1T2xvMElqa3JVYzNvOFhBM3YzUkxGdWl2ZnZDVk8rckJRSldR?=
 =?utf-8?B?N3JZbUMwMnkwNUp5Y2gva1ZZdXcweVhvZzN5dHIvMkNKNjJyL0V2cWJSWmxG?=
 =?utf-8?B?bGNMV04zbCtFWW1OakJST1JEUks3c0d4NEU5NE1sakdyangyeCsrWWdKWUFv?=
 =?utf-8?B?Q0xrR2M3UnUwYXFHeU12MWVmLzJLYWZtaVE3cVBxQzhoL1BDelVmRnlYMTMv?=
 =?utf-8?B?ZHJmSTZhTWRPNmlucjN2dnZmR1dGY1JBTzJ3VFdWL2tyMzVaYTlkdVl1Z0tX?=
 =?utf-8?B?NzBKM1F0czlCV3ErdVVFSk5UeWpMNnNwK0c1b2lNZXJIUEIwWnBYdDd2cU14?=
 =?utf-8?B?bFNMK0dqcGdVbVNtdE5jR0V5M2R1M3NXTG52ZjhPMXk5U2FTNTNGWnU2K3pB?=
 =?utf-8?B?a1dOQzNkSVNTYnFSMXBTalpIWGJEVjJTWE1FVW9WVWJsbC9LdS9UdmRJVlVj?=
 =?utf-8?B?eFBEMktBQ0hETDRzVzZqY0RUNjFJZk1sMEl3TTNZVmI1dklsWUFBMlRQUVRu?=
 =?utf-8?B?OERHRVVKbHJ6cTU4R3EweS92eTZJZ0RaTHdTMk0rYXlHZDRCU1UrSFQ4VTdL?=
 =?utf-8?B?TnZMenZzWGJ2alhQTjJDU1lNcWRnVHNkR1h0MnJzbkRld1FLVnVkUnh1cWgw?=
 =?utf-8?B?ZTE4WEk5NjV2ZzVPNHA3bHlRek5EaHFvSFFGS3JJcTFTU01oak5UT1ltL0RW?=
 =?utf-8?B?UDduREhQc05yTjNYdHVwZWxUZ2cyZ0JmN1R5Z2Y1VDB5dENSV3RmSzRMSzlH?=
 =?utf-8?B?Q0FURjV3dlNwV1dJcENEVUtwSnJBNjl0ZzI1U05ld2ZVWDNwYjZIdDZJRjdS?=
 =?utf-8?B?djYzckE1bWNFRk5RNXk4UUNLblhNeDN5ZzlmanBpMmNMUkhZZnBoTlg5cHZt?=
 =?utf-8?B?SE5nQXBBNXRBc0pYY1BCaXFaMk1vMkplUnFObGV3QXFOclJWU3VXbzBLZVpa?=
 =?utf-8?B?VWl4RlFrakNuN1lZbFhVTFNSSHFQbG50MkEvK1NYSWxsNGhKend2MGlYRnJp?=
 =?utf-8?B?WTgraHZuRWs0eXJEK1YzZElNUTBFNHdWeWVrMDJSMjB0MFlHTG04V045QVM1?=
 =?utf-8?B?aytreFV1RnhsMUxvN250RExCaTlZSkJWWjgrem9JU3RTK0lYUURUK0k3R3Vv?=
 =?utf-8?B?eExiOUZHQ0dQTHZhSDFxNTFCVy9LR29VaDBZalhMZnZFNHZ2MFU0Vk1TMlZt?=
 =?utf-8?B?cmJSV0x4Z0l0NEVTM0M0Qkl1UlZJL3BsVFl1QjdxamhadGlGNEFqYXJqZzg0?=
 =?utf-8?B?VFIzV3RYYWp5SFFyMVJnbG82VEU5ZWZPZlphdy96MlFkUUdqSkE5WktxOG9L?=
 =?utf-8?B?RXZBL2FBQlRpa0szd3hxWjA3bjFpMGM0aU5NZ2ZoT1RqSHN5TnBxUT09?=
X-Exchange-RoutingPolicyChecked: Zz78Q8yucoHhBuOLd5bpbiWy+tf8DCu/16vMwDnG63GWseqlNGUZK51BhSSW5RTFcwLSznDlxuyK8SgflEv6TKJ/HqMVKTcc8f75fVchqGx28t/zYBClIQ7n0McjHN6Va9DOxX3cVYjCeFqHONFywSpLEs5nviuXB7qzMwFwjJ4MhYJRYFNEb3N03xckGPxkPiLb15l2rnHjxTHI6YGIEfabGS0fT6KirNj4ZJz5JwwpzQVyL+OC+RtStmJB+Bq53bO1ZlvfUWGpwGvdlAZs9X6GBLMD6CDIgtkSnHuGJQgTiDrtlf6Hw/iG/1+80NkeKtg9fdFJp8Y2JKzWMPyV+Q==
X-MS-Exchange-CrossTenant-Network-Message-Id: 396f8743-2f61-432b-703c-08dea1016982
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2026 06:27:37.1472 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EjLjLRx84OxeTOYQHz9RMUVHFM0Zv/4ek3wWlWtreywZe5wPRZ1pOvMGkDMEs2X+GJAr19fYYwEpd/ta+SRREQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF1721FD39C
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

On Wed, Apr 22, 2026 at 11:16:37PM -0700, Matthew Brost wrote:
> On Thu, Apr 23, 2026 at 04:04:32PM +1000, Balbir Singh wrote:
> > On 4/23/26 15:56, Matthew Brost wrote:
> > > Introduce zone_appears_fragmented() as a lightweight helper to allow
> > > subsystems to make coarse decisions about reclaim behavior in the
> > > presence of likely fragmentation.
> > > 
> > > The helper implements a simple heuristic: if the number of free pages
> > > in a zone exceeds twice the high watermark, the zone is considered to
> > > have ample free memory and allocation failures are more likely due to
> > > fragmentation than overall memory pressure.
> > > 
> > > This is intentionally imprecise and is not meant to replace the core
> > > MM compaction or fragmentation accounting logic. Instead, it provides
> > > a cheap signal for callers (e.g., shrinkers) that wish to avoid
> > > overly aggressive reclaim when sufficient free memory exists but
> > > high-order allocations may still fail.
> > > 
> > > No functional changes; this is a preparatory helper for future users.
> > > 
> > > Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
> > > Cc: Andrew Morton <akpm@linux-foundation.org>
> > > Cc: David Hildenbrand <david@kernel.org>
> > > Cc: Lorenzo Stoakes <ljs@kernel.org>
> > > Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>
> > > Cc: Vlastimil Babka <vbabka@kernel.org>
> > > Cc: Mike Rapoport <rppt@kernel.org>
> > > Cc: Suren Baghdasaryan <surenb@google.com>
> > > Cc: Michal Hocko <mhocko@suse.com>
> > > Cc: linux-mm@kvack.org
> > > Cc: linux-kernel@vger.kernel.org
> > > Signed-off-by: Matthew Brost <matthew.brost@intel.com>
> > > ---
> > >  include/linux/vmstat.h | 13 +++++++++++++
> > >  1 file changed, 13 insertions(+)
> > > 
> > > diff --git a/include/linux/vmstat.h b/include/linux/vmstat.h
> > > index 3c9c266cf782..568d9f4f1a1f 100644
> > > --- a/include/linux/vmstat.h
> > > +++ b/include/linux/vmstat.h
> > > @@ -483,6 +483,19 @@ static inline const char *zone_stat_name(enum zone_stat_item item)
> > >  	return vmstat_text[item];
> > >  }
> > >  
> > > +static inline bool zone_appears_fragmented(struct zone *zone)
> > > +{
> > > +	/*
> > > +	 * Simple heuristic: if the number of free pages is more than twice the
> > > +	 * high watermark, this strongly suggests that the zone is heavily
> > > +	 * fragmented when called from a shrinker.
> > > +	 */
> > > +	if (zone_page_state(zone, NR_FREE_PAGES) > high_wmark_pages(zone) * 2)
> > > +		return true;
> > > +
> > > +	return false;
> > > +}
> > > +
> > >  #ifdef CONFIG_NUMA
> > >  static inline const char *numa_stat_name(enum numa_stat_item item)
> > >  {
> > 
> > 
> > Without any usage/users, this is hard to review. I don't understand the heuristic
> > or it's logic as applied to fragmentation either.
> > 
> 
> Sorry—it’s always confusing who to CC on cross-subsystem series. Last
> time this occurred, we agreed to CC everyone listed in the cover letter,
> which I did. Anyway, let me provide the Patchwork links...
> 
> Cover letter: https://patchwork.freedesktop.org/series/165329/
> TTM patch which uses this: https://patchwork.freedesktop.org/patch/720036/?series=165329&rev=1
> Xe side which uses the TTM helper: https://patchwork.freedesktop.org/patch/720031/?series=165329&rev=1
> 

Also if you want grab whole series locally here is what I do when I'm
missed on a Cc:

b4 mbox <msg-id>
mutt -f <msg-id>

So here, with msg-id from cover letter:

b4 mbox 20260423055656.1696379-1-matthew.brost@intel.com
mutt -f  ./20260423055656.1696379-1-matthew.brost@intel.com.mbx

Matt

> Matt
> 
> > Balbir
